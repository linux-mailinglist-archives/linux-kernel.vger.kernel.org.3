Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC344F9820
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiDHOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiDHOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0B531CC400
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649428471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7Egd3v0QGZRIC382enFxAdFYzTUSG9bvqRfc1sQGc4=;
        b=Hga7U7LlWr28+vl4bGth55GwRzZCO1YOOcTeY/YCP0d9azRSteLk3Hk28drmUmv30LITaq
        2gkKg4fdU68q/BhHPQy/q0Y0l2vCc5/oVqjbpM+6a4MGjY6/6GiQL8ECY27hdJifCPygUI
        YAkO24WvJsX8Wt7LecoIFnRinhGbdb4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-fr_tK0BwPqGPE6QS-cPrgA-1; Fri, 08 Apr 2022 10:34:29 -0400
X-MC-Unique: fr_tK0BwPqGPE6QS-cPrgA-1
Received: by mail-qt1-f200.google.com with SMTP id j6-20020ac85c46000000b002ed0be14d3aso917392qtj.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7Egd3v0QGZRIC382enFxAdFYzTUSG9bvqRfc1sQGc4=;
        b=vClssjdDkmPJ9dYSHfKil2jynNh2aA60GenbQ52qHvvNePxsEAUqfYQCaKqjxc32eH
         a4+tQmrA3CSE8Hyu1HDX05JeuZdi+MELjHpzTogbTuFgP0qUPG9B1mll5VV/Z0Iy0QHF
         uUwTxUmRz/2VVyQrFvgK0JpTpl3E1vRLvSTXx7jTbeDDnj2z7tbJe+6V6CMRwFM74WS+
         ufvvf1wy4O+VVtMDj8jBqYUxCCidssDc2QxcEj5NFXMpPm3OH/dLiX2asAN68Jyk3tqU
         C2rUV/V5bVrGfRrzdTVFRGfhlqpsxPZ2oDBubxmo/dQsryB/Z1Kl97PaoCTf+qlVEagV
         CUeQ==
X-Gm-Message-State: AOAM533QYfauwmigbOyhgLYiKtl0v5DeS0QMdyL6d8FhxBxqjXZclwxz
        Np89j2kRESZRZcquiaxyprVNgHe6aHp5mhs5xOuwl4IKbkRUsPuA93OFURPwuWNMJ9U7fwflzT7
        H2ERetuBWihlHCXbdJTnJ541r
X-Received: by 2002:a05:6214:2684:b0:443:ce3d:5295 with SMTP id gm4-20020a056214268400b00443ce3d5295mr16444353qvb.57.1649428469348;
        Fri, 08 Apr 2022 07:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKRnK9m8ieH98Tqid9txPJskujy0WAzGUcIuDCsqcanpH5Ldlx9htehVTz0Pa2DWTYmypCmA==
X-Received: by 2002:a05:6214:2684:b0:443:ce3d:5295 with SMTP id gm4-20020a056214268400b00443ce3d5295mr16444336qvb.57.1649428469151;
        Fri, 08 Apr 2022 07:34:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c11-20020a05620a134b00b006809a92a94fsm13166046qkl.79.2022.04.08.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:34:28 -0700 (PDT)
Date:   Fri, 8 Apr 2022 07:34:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     madvenka@linux.microsoft.com, mark.rutland@arm.com,
        broonie@kernel.org, ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        jmorris@namei.org, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220408143425.iovzmmdxxh77rjtz@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
 <YlAUj6w6fePEo7v+@hirez.programming.kicks-ass.net>
 <YlAidG0qYe+yh/vg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlAidG0qYe+yh/vg@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:54:28PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 08, 2022 at 12:55:11PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 07, 2022 at 03:25:09PM -0500, madvenka@linux.microsoft.com wrote:
> > 
> > > [-- application/octet-stream is unsupported (use 'v' to view this part) --]
> > 
> > Your emails are unreadable :-(
> 
> List copy is OK, so perhaps it's due to how Josh bounced them..

Corporate email Mimecast fail when I bounced them, sorry :-/

-- 
Josh

