Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40711583962
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiG1HWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiG1HW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6034D32D8E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658992946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JE/wrsFQ4IE04NndGihc8P0L8CV49vxlmbLKxjK57Ow=;
        b=ezeorW6wcs5vvIKTplu339DudMeocqm1gIHDnW+IA3TzJoxOfqifZExjo/GzrbiFCus3fx
        hNFyR015lMl124Ja2M0R+I08DZ4PbnJeylSUrWV1eA9gJJinLvCHhM/9F8h0vSNys3d43p
        kctC/ttsjJddA2uXnsVrJbxs8l6Dyug=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-EpRutzYoMLmtJS8Ai-ziZg-1; Thu, 28 Jul 2022 03:22:24 -0400
X-MC-Unique: EpRutzYoMLmtJS8Ai-ziZg-1
Received: by mail-wr1-f71.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso129381wrg.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JE/wrsFQ4IE04NndGihc8P0L8CV49vxlmbLKxjK57Ow=;
        b=rU4QulB2Ed98HpvO1s7aW4B76lqoJ5oCwCBfV1ZJjlTXs+2h3emyptRPfOXoQPmfz+
         LKUpgTqUbPiqS9uPD4vttdG/RLR//5YXmZ9t+jJq/u0s4m7idlatIfOdV260YVZwEB8s
         /AfRuRXbBWtPwVEPjn5qYZDcn/Zz/MeDXtFSIyC3+3HUvE0w0QNKvtSaB3OmoeWluv2j
         qDxF2huChMW9DsEFp9co4hQ9LyC8Ca849PoIHIFceNAI8xdx75kz2OA1OlXPfLxVkoMi
         ow5lZZm/TVYSwA20Qm9LDjWMM+EW5TmZHZPNxMvjVaYdrXFTMAX+L/tkSb4hTXkf3Ak0
         znsQ==
X-Gm-Message-State: AJIora/jE5pgvscXRp7rRP2dUIXNPZ4gSjPqvSG77PQuh6Eb4v0KLouw
        vbXvE/EisQQGWRz9Po/PDfkg7YjGOpb18F6yJgIJECWFTFPKpF2r0dvsjnEvuZ/ouWkZLXQ7I04
        8IumHG9I6bOLJ1KERhpNtNG4=
X-Received: by 2002:a5d:64c7:0:b0:21d:a743:394 with SMTP id f7-20020a5d64c7000000b0021da7430394mr15843653wri.628.1658992943270;
        Thu, 28 Jul 2022 00:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3d8HNVPxziDqqmZRHhJn8tEmGPDtxLHvknbiGk9JeaU8V7vBGGLOYnxRBG5VgEQQq43RkUg==
X-Received: by 2002:a5d:64c7:0:b0:21d:a743:394 with SMTP id f7-20020a5d64c7000000b0021da7430394mr15843636wri.628.1658992942925;
        Thu, 28 Jul 2022 00:22:22 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003a317ee3036sm397160wms.2.2022.07.28.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:22:21 -0700 (PDT)
Date:   Thu, 28 Jul 2022 08:22:20 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     atomlin@atomlin.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, dianders@chromium.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2] scripts/gdb: Ensure the absolute path is generated on
 initial source
Message-ID: <20220728072220.xhyg65izemzcdojr@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220712110248.1404125-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220712110248.1404125-1-atomlin@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-12 12:02 +0100, Aaron Tomlin wrote:
> Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
> is created. Currently 'os.path.dirname(__file__)' does not generate
> the absolute path to scripts/gdb resulting in the following:
> 
>     (gdb) source vmlinux-gdb.py
>     Traceback (most recent call last):
>       File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
> 	import linux.utils
>     ModuleNotFoundError: No module named 'linux'
> 
> This patch ensures that the absolute path to scripts/gdb in relation to
> the given file is generated so each module can be located accordingly.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  scripts/gdb/vmlinux-gdb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..3e8d3669f0ce 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -13,7 +13,7 @@
>  
>  import os
>  
> -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> +sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")
>  
>  try:
>      gdb.parse_and_eval("0")
> -- 
> 2.34.3

Any feedback?


Kind regards,

-- 
Aaron Tomlin

