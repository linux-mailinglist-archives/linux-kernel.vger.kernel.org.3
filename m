Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FF505C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiDRQOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiDRQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B9A27172
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650298310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kc5lp6HIebTiS6SD8VstSYY5zjx55zGLVR2F4cO28oE=;
        b=YPnOxQAvvDAaq0UqJTBseqQaEXA7iQjtCeRIvPOMoWPkrPaj8ghas2UHvE2HO5fWW8T3Tu
        cljcg5Le8EFGGefxDmT3qgCMc+m2kRnAtPlho7SmU9FUYb9Z3YVqBqTDy6DgRM7emS8un4
        sEHhAffuP+XVcgsOq7BEm/gYh1aPlj4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-9ImO3YPVPWuWQG4tqwwlcQ-1; Mon, 18 Apr 2022 12:11:50 -0400
X-MC-Unique: 9ImO3YPVPWuWQG4tqwwlcQ-1
Received: by mail-qv1-f70.google.com with SMTP id m16-20020ad45050000000b00446393a7a9fso6716934qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kc5lp6HIebTiS6SD8VstSYY5zjx55zGLVR2F4cO28oE=;
        b=eWpl1jM5V1mrv8ZwkcJqyLwZyI9U+VueLadCYKGA7IejJLeOlV09cQnbzpaDVZQnXX
         t/1nKpjg1/frDyXhXzZIRSV3M/Vta8BZCzTFthnqkMMhuY6uGB9Llp1mjtJ7uBYrZes9
         E1v+ZaV6U7a0j1M02oMVOym+utvwsEZwClQpFbDuL1TmDpWXhVydGHyrlOuJYXCPLOun
         lbhr2PsAD3uNb2YYoDZYbnUmWHuf8OjCGIUfszk5y2R7Y4vqCU6us67KbL6tl9R0N1Lv
         q+IA0RyJszTG0Cyxe3rjYi3lawoDujQPco1YYXfnE79bXPuxG82cD1awhf2I/D/0Ron+
         M43g==
X-Gm-Message-State: AOAM532YZxmKMItCv83AAWnIB4I7glfAn2iucamlDE4OiiKfCVh79MJs
        XqKnMat9whfMWJL1Sw1F0WMdTnqXWmshES8U15kVhs+YgyB4GWmaeL8bA7+vqTukOF4WFanXD36
        BjVr1QEb5vhLkHfHhXzHzPuX/
X-Received: by 2002:a05:622a:1c0d:b0:2ed:1335:97ba with SMTP id bq13-20020a05622a1c0d00b002ed133597bamr7409399qtb.485.1650298309245;
        Mon, 18 Apr 2022 09:11:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpxyZFBVbqcMwvi9NQe9+Q4Yv/Ps3/MmukjEwG1VNQ8GX8Sud2aR+UhEWRMYin6uluXw4eWA==
X-Received: by 2002:a05:622a:1c0d:b0:2ed:1335:97ba with SMTP id bq13-20020a05622a1c0d00b002ed133597bamr7409371qtb.485.1650298308929;
        Mon, 18 Apr 2022 09:11:48 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id w14-20020ac857ce000000b002f1ccd62225sm8537050qta.79.2022.04.18.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:11:48 -0700 (PDT)
Date:   Mon, 18 Apr 2022 09:11:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        mark.rutland@arm.com, broonie@kernel.org, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220418161145.hj3ahxqjdgqd3qn2@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
 <20220408002147.pk7clzruj6sawj7z@treble>
 <15a22f4b-f04a-15e1-8f54-5b3147d8df7d@linux.microsoft.com>
 <35c99466-9024-a7fd-9632-5d21b3e558f7@huawei.com>
 <20220416005609.3znhltjlhpg475ff@treble>
 <0abfa1af-81ec-9048-6f95-cf5dda295139@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0abfa1af-81ec-9048-6f95-cf5dda295139@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 08:28:33PM +0800, Chen Zhongjin wrote:
> Hi Josh,
> 
> IIUC, ORC on x86 can make reliable stack unwind for this scenario
> because objtool validates BP state.
> 
> I'm thinking that on arm64 there's no guarantee that LR will be pushed
> onto stack. When we meet similar scenario on arm64, we should recover
> (LR, FP) on pt_regs and continue to unwind the stack. And this is
> reliable only after we validate (LR, FP).
> 
> So should we track LR on arm64 additionally as track BP on x86? Or can
> we just treat (LR, FP) as a pair? because as I know they are always set
> up together.

Does the arm64 unwinder have a way to detect kernel pt_regs on the
stack?  If so, the simplest solution is to mark all stacks with kernel
regs as unreliable.  That's what the x86 FP unwinder does.

-- 
Josh

