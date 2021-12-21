Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466847C232
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhLUPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhLUPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:05:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB26C061401;
        Tue, 21 Dec 2021 07:05:12 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso16936597ots.6;
        Tue, 21 Dec 2021 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRnXnmyb6lR/XMncjwgJbPcN41DhJNw4ep7y8f1hKDM=;
        b=ffNL9EpvuvXuDSU8RMtnu6zASE/YCJmFachFtfhhpJLzcMVGzaniQO4UQ5EGEls7Ev
         CAUbWxvcoyUxw2VTT10hfE/5QLf4dD5/Moo83UtWvQzunzGawdTGU8uAv0pG/jBFImg1
         gfhcBgHqwuIKWZ7oRh7ecec4hz7XBlkylj3X9rtGkmc0dMkQb2ApcvcNfGp7/r7Nqhvs
         Utx/IALmT6KytVNckfN1RsPtvtCqmbtgDC/JcOsf65UTbRNf6kIllW4G7FMQOlIZnv3n
         Lpp3K8sHdMal9YiqB4xtlyEKOjsc5af1PqstP51PBjJTWWAFdQfLD3gajVTL6b7ZtGHy
         /Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FRnXnmyb6lR/XMncjwgJbPcN41DhJNw4ep7y8f1hKDM=;
        b=XfFggdbNMkEhkWE8fNvlHH6etXmPLOhZPYgrsEJhs6nmt441efJ42GyVEr57SZNPUV
         y90iwYqrmX2o7Ot+2MkoMdm48YlFJs20uHFOfxTzBvMiCb5VBY7tvh1RkePtxTxCpJle
         iMh5rltDVfjVTsZwg0WaAvYkUNC46faNHIg+ZS+0F/ZNIZPITm9VmZA79w5//p7FKdwB
         6Ig/kSROQwjksoDrMtOvYnvm+kT93EedT+uEqs0HYJmpNtrmBzbCWNZtrrLTfuF9PrF1
         rud+8+ywBCngKOqTZz7qo3WrUNw5qdjWaOh0j5thFs/bOSvjFsz8rlJOX3WGKisQkyOe
         5Itw==
X-Gm-Message-State: AOAM532u32OCZ8SmAXQgf/4BeeP2tJSneyK3TOP3bfCqtx5Ae9mHdeWm
        R9/6rwDEiUHzo7lEPcownBs=
X-Google-Smtp-Source: ABdhPJyFyyoABDklh1XSAhlx5q0txC/kSLkBjaQ3+0khy4kqEpH7sWJSVYbNE09esExfw8jjT0fdzQ==
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr2496050otl.85.1640099111852;
        Tue, 21 Dec 2021 07:05:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w22sm3520214ooc.47.2021.12.21.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:05:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Dec 2021 07:05:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: s3c2410: Fix getting the optional clock
Message-ID: <20211221150509.GA2753412@roeck-us.net>
References: <20211212170247.30646-1-semen.protsenko@linaro.org>
 <b618ff5b-ee41-2c29-5074-24fd4d0f0933@canonical.com>
 <CAPLW+4=wcWv4P_M8kQDjB=QfT5N+mFKm0mUdSDjGSgLg=pRGSw@mail.gmail.com>
 <4ad8719c-1476-3226-e426-a171b46ca568@roeck-us.net>
 <CAPLW+4=ZoBqhLpNPiknTjqMXK5wJtOJtn4=99_kvaC3DBb_eqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLW+4=ZoBqhLpNPiknTjqMXK5wJtOJtn4=99_kvaC3DBb_eqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 01:52:32PM +0200, Sam Protsenko wrote:
> On Mon, 20 Dec 2021 at 23:08, Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
> >
> > I added the patch to my watchdog-next tree, but Wim handles all pull
> > requests.
> >
> 
> Thanks, Guenter! Do I need to take any other actions, or Wim is going
> to take patches from your tree? I just checked [1] (master branch),
> and I can't see my patches there yet.
> 
> [1] git://www.linux-watchdog.org/linux-watchdog-next.git
> 
Wim usually takes patches either from my tree or from the list,
but he does so shortly before the commit window opens. You don't
need to do anything else.

Guenter
