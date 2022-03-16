Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523BA4DA8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353360AbiCPDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiCPDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5045D64C4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647402233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAnnOD1TFAfWyqqMW/Wmcf4iVq3MFqF1gnAUhVDPFsI=;
        b=US73mtLiZgsQZJB7I6/SdH5+BkYoEr+40XEmkjx/QPHjYyBp1/NIzGicH8cI9eaeTnlkFR
        8o+sVcGLmSfiWV9nwsR0RbN0dGEHQpDxBPq3slhpJKarWB4dcrN6VycVkMgk6FL966w63V
        6987+RHbW854kVQ2VYXs773y2L1nmNU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-7mBGjSNXNESN7KrtFbi_4g-1; Tue, 15 Mar 2022 23:43:52 -0400
X-MC-Unique: 7mBGjSNXNESN7KrtFbi_4g-1
Received: by mail-qk1-f197.google.com with SMTP id i2-20020a05620a248200b0067b51fa1269so733609qkn.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZAnnOD1TFAfWyqqMW/Wmcf4iVq3MFqF1gnAUhVDPFsI=;
        b=v6odbREzCGipifsUYWoANEpkRRKg3FK8O/Y3iRF39L/j6EIydp/+I2ASQk2OAWqOQx
         /ck7/KpI4EqiybSp6/UwjJcDZAUIQTfs0DP6MRqFVy6kmSWv6NyDrQI3J77lC4vCaY1g
         uThzOTNyWVIX6qGnd6qP1jiadh2N3SKJisrfXKaOie3RdXyu1B5wvAXz3RapPdkZr/4l
         j5/kGfzL9odLsi5nGPM1WhFRvrP34j36adk2ssAhecM6S421m9w+kABAeC1waZJicQoG
         3P6h9T8+RDwJ2obpcIua8+pI19qlqp5J1ARx0F4L55YQehvoMmevtxqDtpmHN07CH5fh
         ZJXA==
X-Gm-Message-State: AOAM530EL0uagcQG/QEKj/wxyTATfovp8lRQrN0oaJjw0HxnYp4TU9Fy
        2Sd8Kn7VoutBN2JGw7A+e5ysIXV120dvQg2bhHVT+zsSu0/0GgyV+STesL/RTHvlZ2dfQpa3Q6s
        X+SKoUGvMl9OfxtqQfEo7C3Ae
X-Received: by 2002:ac8:5d94:0:b0:2e1:ce44:5041 with SMTP id d20-20020ac85d94000000b002e1ce445041mr11251361qtx.356.1647402231702;
        Tue, 15 Mar 2022 20:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpH+p8m21wqZy7u+B52bawoIc/wfywaIVHyd24H+3Mr5FLKf3ex5fY0aUAsR/hQ7OuD10v5w==
X-Received: by 2002:ac8:5d94:0:b0:2e1:ce44:5041 with SMTP id d20-20020ac85d94000000b002e1ce445041mr11251347qtx.356.1647402231457;
        Tue, 15 Mar 2022 20:43:51 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id y24-20020a37e318000000b0067d43d76184sm377053qki.97.2022.03.15.20.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 20:43:50 -0700 (PDT)
Date:   Tue, 15 Mar 2022 20:43:47 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 06/11] arm64: Use stack_trace_consume_fn and rename
 args to unwind()
Message-ID: <20220316034347.5q55vxzztrpe2pjn@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220117145608.6781-1-madvenka@linux.microsoft.com>
 <20220117145608.6781-7-madvenka@linux.microsoft.com>
 <YgutJKqYe8ss8LLd@FVFF77S0Q05N>
 <845e4589-97d9-5371-3a0e-f6e05919f32d@linux.microsoft.com>
 <YiY6hecX0pVWowQ7@sirena.org.uk>
 <c494fa10-e973-c137-b637-66bde327611c@linux.microsoft.com>
 <YiiT2lFuxc3ob+Zq@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiiT2lFuxc3ob+Zq@sirena.org.uk>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:47:38AM +0000, Mark Brown wrote:
> On Tue, Mar 08, 2022 at 04:00:35PM -0600, Madhavan T. Venkataraman wrote:
> 
> > It is just that patch 11 that defines "select
> > HAVE_RELIABLE_STACKTRACE" did not receive any comments from you
> > (unless I missed a comment that came from you. That is entirely
> > possible. If I missed it, my bad). Since you suggested that change, I
> > just wanted to make sure that that patch looks OK to you.
> 
> I think that's more a question for the livepatch people to be honest -
> it's not entirely a technical one, there's a bunch of confidence level
> stuff going on.  For example there was some suggestion that people might
> insist on having objtool support, though there's also substantial
> pushback on making objtool a requirement for anything from other
> quarters.  I was hoping that posting that patch would provoke some
> discussion about what exactly is needed but that's not happened thus
> far.

That patch has HAVE_RELIABLE_STACKTRACE depending on STACK_VALIDATION,
which doesn't exist on arm64.

So it didn't seem controversial enough to warrant discussion ;-)

-- 
Josh

