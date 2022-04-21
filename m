Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74850A094
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiDUNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiDUNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FCABB7F8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650547214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=LCQ38u6A7MpzQJ92x7kOETUhRB6m7kAQco7/Q/Ua/CC9MSLUdpjvIg7BmRBB5hsybllCmg
        WZw2vCGWZUC6HHqviAiHTZmHUl35HLNmPsZaXUvQ47EipU+R8Cm38sgbkZN2hmeHY+a8Pb
        tndBLfQSVBUssN4BeWWwETFv7aR8hLE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-AjU6D-27OpiFeROxcQvfog-1; Thu, 21 Apr 2022 09:20:13 -0400
X-MC-Unique: AjU6D-27OpiFeROxcQvfog-1
Received: by mail-pg1-f198.google.com with SMTP id 83-20020a630556000000b003aa61747c38so2795495pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ysNTNbr2psFVrS6UcYq+BuiMnSkOg3El0dLlrsZy+mgi3IG5xPr2Ozk7xjTa6/lK9V
         4OEvQ7EHDQrnQ+S05fzzazsSSgAR2YK4qSPjhZ8UFzFDFurf6Op5bbRG2jmsmcTdFJHj
         5u/hKu/3HPguGQrgZHgwsrZNmW4qehDrO8tlqNT923T8RmBt6RpzY3fvMOclqJSb0rDy
         Iqn8DOTBDPlAMa1RKyyWmTzx3XnOWYywVewFkrE93fMOmVjQXYIi0sQgvs1PRR8kRI8w
         fPo7/vizHg/ruNGw7L2nGyq3LshkGDBr3Px8Ca/RtkHcud7PJF0NEi5lmdP8WQIk7xjk
         RE0Q==
X-Gm-Message-State: AOAM533Y60rBWUVL6WyHsfqYdKffxTtu6Sm/Pyq650WU3zV1YCFnb8gF
        38ECOryQK0kK+FnSMuXNVjgAgTmI7WhYOEo2E7GZhAIqcnQwJqy2b8C0Cx27wQYzxfNzkGF3sXN
        C/puoA9B2T9DGUPeVqPg4ETe0
X-Received: by 2002:a05:6a00:ccf:b0:50a:db82:4ae5 with SMTP id b15-20020a056a000ccf00b0050adb824ae5mr3581861pfv.59.1650547212330;
        Thu, 21 Apr 2022 06:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEg/XKr6Ui9gwh2MQYBfHjjkLlJhmxTVmRmjaeYiITKwKssa5krUtFdDxn4eFPTWFfCNVNig==
X-Received: by 2002:a05:6a00:ccf:b0:50a:db82:4ae5 with SMTP id b15-20020a056a000ccf00b0050adb824ae5mr3581819pfv.59.1650547211962;
        Thu, 21 Apr 2022 06:20:11 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lw3-20020a17090b180300b001cd4989fecesm2984649pjb.26.2022.04.21.06.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:20:11 -0700 (PDT)
Date:   Thu, 21 Apr 2022 21:20:00 +0800
From:   Tao Liu <ltao@redhat.com>
To:     joro@8bytes.org
Cc:     cfir@google.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        erdemaktas@google.com, hpa@zytor.com, jgross@suse.com,
        jroedel@suse.de, jslaby@suse.cz, keescook@chromium.org,
        kexec@lists.infradead.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        luto@kernel.org, martin.b.radev@gmail.com, mhiramat@kernel.org,
        mstunes@vmware.com, nivedita@alum.mit.edu, peterz@infradead.org,
        rientjes@google.com, seanjc@google.com, stable@vger.kernel.org,
        thomas.lendacky@amd.com, virtualization@lists.linux-foundation.org,
        x86@kernel.org
Subject: Re: [PATCH 01/12] kexec: Allow architecture code to opt-out at
 runtime
Message-ID: <YmFaAFcQPhSWNEFz@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721142015.1401-2-joro@8bytes.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

