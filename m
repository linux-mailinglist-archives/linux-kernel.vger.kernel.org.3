Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C349BF2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiAYWzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234519AbiAYWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643151341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5eZe6k04P6h4FujwlF9i3vzXzuFnGBmcS8dEFuDl4U=;
        b=LxHMY/hazanFBGqndivwQVEyrzRAB9h+hlOy3PHzdAuGnP/3WRuqud6J+pvJLZcFjaLIHL
        F/1Phv+qYPrZo63WK3L5irSDhp9DuUr2d3FFXds6MpziMDwsEkq/nZullL1PoTIzEsCqxA
        6Lt7acpdahyZjsUHRu9xSD9pH6Ws8Jw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-MHmnVgz1Nka6ZBNEw7vWpQ-1; Tue, 25 Jan 2022 17:55:38 -0500
X-MC-Unique: MHmnVgz1Nka6ZBNEw7vWpQ-1
Received: by mail-wm1-f72.google.com with SMTP id d140-20020a1c1d92000000b0034edefd55caso1654097wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l5eZe6k04P6h4FujwlF9i3vzXzuFnGBmcS8dEFuDl4U=;
        b=3FwNsVCZjOylL1r2DoB4s9u5XM8Apwvl5akaGqQPWE6MVJoOzrtMTAh+Eapvd9g7pv
         6xKlkdcWqJ3/kbDGn+uc3PWKJf2237MFd4FC4QtO6+DHgooAtFFBf0+2pJ9XEhFHje8r
         ZvSiKJF0J0c6VjmB8jkPp+o63QfPTfB3iyTY0t0LcZQHCxXLLSCJSeH51LoAcgTXFUjd
         kJvTNAf6l1GwOscpUHRxPy/Gg0NPYoe+ZHH/HGXg+OR2SUvuLIG9kFM/zFUrqhkRuBOs
         zdbGmt5mRkuc+rS3qsCsSb3LnaL9+nKlSTMV6K+9nwLG4MtoYBrX/coeEa6RVyElGw3U
         Cusw==
X-Gm-Message-State: AOAM533UqPRK4b+/22+yPf69Ih4Vu6Sw18HavoEWhbusLu2PgyoUM2G6
        aoHn0vlIpCzpnfWEruS9iVk5CymbjBuNbU/3XCaN0aerjxkQlqfhav1q6x9l4X8abcs/noz60iM
        5S9Vhwt/7QR20oBmg+WD06Lr6
X-Received: by 2002:a5d:6481:: with SMTP id o1mr5212536wri.634.1643151337093;
        Tue, 25 Jan 2022 14:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM72FiqwBIeZCWiqaero+rda/N1iBvU/aDG+fYvb/Jh1rErqIrF4zFPCKpU1dPpMpFNDQO+g==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr5212524wri.634.1643151336908;
        Tue, 25 Jan 2022 14:55:36 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h11sm1513031wmb.12.2022.01.25.14.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 14:55:36 -0800 (PST)
Message-ID: <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com>
Date:   Tue, 25 Jan 2022 23:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/panel-edp: Allow querying the detected panel via
 sysfs
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, robert.foss@linaro.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>, jjsu@chromium.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

On 1/25/22 22:54, Douglas Anderson wrote:
> Recently we added generic "edp-panel"s probed by EDID. To support
> panels in this way we look at the panel ID in the EDID and look up the
> panel in a table that has power sequence timings. If we find a panel
> that's not in the table we will still attempt to use it but we'll use
> conservative timings. While it's likely that these conservative
> timings will work for most nearly all panels, the performance of
> turning the panel off and on suffers.
> 
> We'd like to be able to reliably detect the case that we're using the
> hardcoded timings without relying on parsing dmesg. This allows us to
> implement tests that ensure that no devices get shipped that are
> relying on the conservative timings.
> 
> Let's add a new sysfs entry to panel devices. It will have one of:
> * UNKNOWN - We tried to detect a panel but it wasn't in our table.
> * HARDCODED - We're not using generic "edp-panel" probed by EDID.
> * A panel name - This is the name of the panel from our table.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Should this new sysfs entry be documented in Documentation/ABI/ ?

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

