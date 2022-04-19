Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804350722F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354082AbiDSPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354062AbiDSPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BAC21E3D0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650383531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2aAIhjhDINQUeDXC2PLVamoVkPYEpaikfODfduHQkQ=;
        b=NQszpD7QrilswiisMD2MwDnMLCT6rdN2qIqMUP0UK6m+hjHGDEC8CneOznSr+5J6/LApoD
        M22Kub8VvoJApJthie96A9WD8Fo2x6EBRw1kQT+CZIBCXG0sdtOs5Ldt+MRQTorihyOjRv
        RmLfNuO06zkcX6bKJI1RRzF8HlDtHZs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-Q5-p1PP7Mtaa81PPTZygoA-1; Tue, 19 Apr 2022 11:52:07 -0400
X-MC-Unique: Q5-p1PP7Mtaa81PPTZygoA-1
Received: by mail-qt1-f199.google.com with SMTP id ay26-20020a05622a229a00b002f20573a0faso2913640qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2aAIhjhDINQUeDXC2PLVamoVkPYEpaikfODfduHQkQ=;
        b=XLCo/VDTStBPhxFwXRFAL1PAmjCRbCK3RMADSqaznm6I4fc7ktJtBYkgbK3jzNRGI5
         V3JPzjX8sMXKlkQ0bOTMgBRSdsKhtbg7lUoUti9+Y7eH5CJkRbEFT0Z8DaWU23Z3oH2U
         EP1B+dSmTSuP99ro5L2TjUV7RBzs3oZlf9jCOv3ZYbU70prlN8duFu8oPdmEXt9s8tL2
         7sEj5MIVoiZhejlPxEYOdt2aZ4uqyTC1dPWvRwJPZDUIAf+HcfCj2/Cet2XDi9uDFrFC
         d0jtWsmfvF5co1k2FYnPryBx+1zxuqUrHJ5mgkP6tBTb+T46lCIwbzh1FHO8iXFH8VTy
         6I8Q==
X-Gm-Message-State: AOAM531jGH58SVELcZja4rB2pvSXhXIIZiw0c3nn1lAVdA7e7NV8uSSQ
        qID52zOpvPpm90l5khOZjJBiIOBfh/a1slIjsLLg3InIg4xMDtx8pOmOu/z+FaHis/BolEOlzFz
        xK6QoIUMaivyb2DOBxMU+64s7
X-Received: by 2002:a05:620a:4687:b0:69c:5016:9ea4 with SMTP id bq7-20020a05620a468700b0069c50169ea4mr9910666qkb.624.1650383527426;
        Tue, 19 Apr 2022 08:52:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYtIr2Qt0uy3XqbQvayaX2ydS0/i/P8tJV1N5aJImgh3yxZ8vccF7r0hjvmZePaeKO+nwvhA==
X-Received: by 2002:a05:620a:4687:b0:69c:5016:9ea4 with SMTP id bq7-20020a05620a468700b0069c50169ea4mr9910654qkb.624.1650383527161;
        Tue, 19 Apr 2022 08:52:07 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c4-20020a37b304000000b0069ec13803adsm196602qkf.7.2022.04.19.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:52:06 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:52:04 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] objtool: Fix function fallthrough detection for
 vmlinux
Message-ID: <20220419155204.dpinfcxm5xburyig@treble>
References: <cover.1649718562.git.jpoimboe@redhat.com>
 <b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:10:32PM -0700, Josh Poimboeuf wrote:
> Objtool's function fallthrough detection only works on C objects.
> The distinction between C and assembly objects no longer makes sense
> with objtool running on vmlinux.o.
> 
> Now that copy_user_64.S has been fixed up, and an objtool sibling call
> detection bug has been fixed, the asm code is in "compliance" and this
> hack is no longer needed.  Remove it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")

-- 
Josh

