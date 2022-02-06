Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F054AB009
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiBFOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbiBFOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:44:02 -0500
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:44:02 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AF24C043183
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdl8CfH3Z3HiaQzbi8nArohvqswPkyc3SDVPBJGLfj4=;
        b=icFX/IC1jOh+VN5Cl4GAHPu80J7qjmzsTxm748SZGm9qOLGq4Fp+zLFDLNBeP6rkKD2fwH
        9HjC0Ymo2oJ8kRm7HBV2zST/jeJEhcVXpqfC2mvPTQLAfJ3gyg36FKr5t78HudhePVTzs5
        pDWNhdNb8lAIzqQRkqZCpYXvQqDA5RI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-xuyTO2krMSOc2qU7XKBuzA-1; Sun, 06 Feb 2022 09:42:50 -0500
X-MC-Unique: xuyTO2krMSOc2qU7XKBuzA-1
Received: by mail-wm1-f69.google.com with SMTP id bg23-20020a05600c3c9700b0034bb19dfdc0so1408929wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdl8CfH3Z3HiaQzbi8nArohvqswPkyc3SDVPBJGLfj4=;
        b=pIi9bdsVF+X3ea/q/akol2G0cs5EsTAlHq8848+f22atqpyfTntwQV5teH7qdksMCD
         GqwS/EzjkljNKf/EiZpmxBvhggFq468iNLD4xJRorkmLq8jhwFYbvEPT7krRn7KgN2Bi
         SJPlimc1zvvkRcs48k4PJoVZKMcDk1yrKMArij3dL+ihgvmutFvFnTNZmCeneQY00MgZ
         2g0QKeEydUwsPfQMBh/q5f/2FOc+8iWy+I+25hF12AE+bpAn0FJC2HLo6DW6LyTYZ4C5
         /izP06K/Nq3XqnUIcEsrbZOrx3X4dnjj9e7tJEW7AyZmVtAYWUvVw+m8ww78xya5hlVS
         DJvg==
X-Gm-Message-State: AOAM533bxo7qW3NqhkM56xeFmE60LmHRZ4fnl2cUOkb2WimyRORo3Y+u
        AJm17qtM6YaJHORPvSgrztS6uzQO0dyGntz60bv3KA8SdGmQHP+yISfO+wFLbkSyJSeTkSvdQcL
        EGKTWm7t/IsATtB0j/9w12Lo=
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr6713130wrx.230.1644158569747;
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5HUKPoAB+azfk61camj45+zxovHaHwEzO+suKg+ekvuId+ykStSst/zq3NR4RoL4UfMJj/w==
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr6713114wrx.230.1644158569569;
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c10sm1179758wrq.87.2022.02.06.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:42:48 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com,
        void@manifault.com, joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206144248.xidnurpm6xsacws3@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-02 16:20 -0800, Luis Chamberlain wrote:
> Thanks for all this work Aaron! Can you drop the RFC prefix,
> rebase onto linus' latest tree (as he already merged my
> modules-next, so his tree is more up to date), and submit again?

No problem and will do.

> I'll then apply this to my modules-next, and then ask Christophe to
> rebase on top of that.
> 
> Michal, you'd be up next if you want to go through modules-next.
> 
> Aaron, please Cc Christophe and Michal on your next respin.

Sure.

Kind regards,

-- 
Aaron Tomlin

