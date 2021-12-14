Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F6473D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhLNGnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:43:16 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39747 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhLNGnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:43:13 -0500
Received: by mail-ed1-f43.google.com with SMTP id b7so361715edd.6;
        Mon, 13 Dec 2021 22:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mES/VN9NDUylN7hikeYFALLjEFWfcxTzSl0FnDEQ4qo=;
        b=QUttYACoGErkqDpq8YTWu3RDTmi0moLK916QoiQZT+4TYJIGojHij+GJ9WrG2q3GPe
         HgRqIj//Pb3dxx6lFH7cHijW+d65bTsH9fTeRB9CMfpOiZslJnvdxisYp4FafmuSja+t
         gFxblUOZGlVbmm+On2Vmi5E/oCcd/CPpSzuT+IYPbUENFXsh79fcNu11FHm5o9yx5O97
         K1IgA99Z9QJrO8ObW4M4HeMp6Axnanio2fHDwbdtMELIT8KpyuwIVHIng3OrwBSf1iQT
         Z6pHFn/HNC80uu6SObjOhyvwPB5xodQCCeOgKyX+jA9ZdxKsKCO5BGRCKbz7ejokhlfh
         cMjQ==
X-Gm-Message-State: AOAM531SPWtWup4ko5lMSfg4dkG/6HCgE8OtDtguu/y9P+XQ/VAuYMyg
        ms2mKM7UddIcheYxRHXNzaDGqUIgWFA=
X-Google-Smtp-Source: ABdhPJwoeQCTf8Mof4FF699wk5L77oT25Ghoc8KhHQrzUkQstWBRt8nQILINgn+e7vIb09ikundH8Q==
X-Received: by 2002:a17:906:c08:: with SMTP id s8mr3626628ejf.673.1639464191777;
        Mon, 13 Dec 2021 22:43:11 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id e19sm7251549edu.47.2021.12.13.22.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 22:43:11 -0800 (PST)
Message-ID: <8bbd1a77-5f88-bb97-db88-6842df2e3e3c@kernel.org>
Date:   Tue, 14 Dec 2021 07:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] tty: rpmsg: Fix race condition releasing tty port
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211213195346.12894-1-arnaud.pouliquen@foss.st.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211213195346.12894-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13. 12. 21, 20:53, Arnaud Pouliquen wrote:
> In current implementation the tty_port struct is part of the
> rpmsg_tty_port structure.The issue is that the rpmsg_tty_port structure is
> freed on rpmsg_tty_remove but also referenced in the tty_struct.
> Its release is not predictable due to workqueues.
> 
> For instance following ftrace shows that rpmsg_tty_close is called after
> rpmsg_tty_release_cport:
> 
>       nr_test.sh-389     [000] .....   212.093752: rpmsg_tty_remove <-rpmsg_dev_
> remove
>               cat-1191    [001] .....   212.095697: tty_release <-__fput
>        nr_test.sh-389     [000] .....   212.099166: rpmsg_tty_release_cport <-rpm
> sg_tty_remove
>               cat-1191    [001] .....   212.115352: rpmsg_tty_close <-tty_release
>               cat-1191    [001] .....   212.115371: release_tty <-tty_release_str
> 
> As consequence, the port must be free only when user has released the TTY
> interface.
> 
> This path (inspired from vcc.c):
> - moves the management of the port in the install and clean-up tty ops,
> - allocates the tty_port struct independently of the rpmsg_tty_port structure,

This looks rather wrong. Why not to use tty_port refcounting?

> - uses tty_vhangup and tty_port_hangup.

OK, but don't store a tty pointer as it looks racy. You should use 
tty_port_tty_get instead.

Hm, we look we need tty_port_tty_vhangup (aside from 
tty_port_tty_hangup). There are plenty of drivers doing:
     tty = tty_port_tty_get(port);
     if (tty) {
             tty_vhangup(port->tty);
             tty_kref_put(tty);


> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

thanks,
-- 
js
suse labs
