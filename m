Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD25E4FC27A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiDKQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiDKQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D948511C0D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649694893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuDooJV2r3lRDseKl98XLYOZNZXFlgTW6Icouk1a/rA=;
        b=DpBpLW7aUHzruasUv3VGExdBqiBy815EtKyd+NplAMVuUwMQnM7tSq37UU65D6tDJQNfMC
        W1A7+8MCvhbc5KuybnXXUrzL/POOzj22JwcTB4d3uU3/nJNRXXsGy4iStIKW5J+b344pdO
        WMm0lPz58orZ9lZnTUusWds/a3ldqI8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-NH5wNXUcPpCiJarDtH5yqQ-1; Mon, 11 Apr 2022 12:34:51 -0400
X-MC-Unique: NH5wNXUcPpCiJarDtH5yqQ-1
Received: by mail-qv1-f70.google.com with SMTP id kk17-20020a056214509100b00443cc96b7d5so16113717qvb.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuDooJV2r3lRDseKl98XLYOZNZXFlgTW6Icouk1a/rA=;
        b=tTZP+xPCWjChRIzUVnYqTcTJVkYzjDo4vOBg2WeGRYzr2SrO2tLVjbrVUOFiTyGmHd
         BaFL8cW7ZCFbvNSzmR7C8lTOGUMSNpr6c6q5BAcHC5+EwS2CIu4+DZ3rSDTPN8A+Wi3b
         gjdQRk23FU6FWGaXSW8y/eXfy3UZn/DRvE9on12dEeaSz0IiDAmNfF98/f1MwNNYNNiP
         r92SIVXnXrmgSNxp2+SNaCV7VKGiDujzFo6pTWtspSZp8TZ43qDT/7RdYGIxMxcVzkWQ
         y3xG1jlZ+bdk5Xp2nZL1xqMwc4jHM1F4uvCEnzKrnceiAjXGc0baVdAD5PP70muyZY4G
         u5aQ==
X-Gm-Message-State: AOAM532jCfzlISh2wAq+ZD2iuiLskWq+FwQgkIDNDA8gDx6lDI2b+w9q
        T8olAx2ntVuqODyejtP1trZdNCIgU3YfjuZWig5Cf68rk58yLVEMlddl+BgMKvFECDn5p44Nno0
        +KRMLSQSnqxxr+jZ7mgqrqJ6h
X-Received: by 2002:a05:620a:4450:b0:69c:11f3:d3c9 with SMTP id w16-20020a05620a445000b0069c11f3d3c9mr160672qkp.378.1649694891173;
        Mon, 11 Apr 2022 09:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhubFLyDLek8KqhligvLIzm/0FG1M86oPwUSg1Uvoy1ilxqbTHCbbp3j0wcBH5MrzHOcEn1A==
X-Received: by 2002:a05:620a:4450:b0:69c:11f3:d3c9 with SMTP id w16-20020a05620a445000b0069c11f3d3c9mr160653qkp.378.1649694890930;
        Mon, 11 Apr 2022 09:34:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id i184-20020a37b8c1000000b00699fa585088sm9289956qkf.46.2022.04.11.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:34:50 -0700 (PDT)
Date:   Mon, 11 Apr 2022 09:34:46 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mark.rutland@arm.com,
        broonie@kernel.org, ardb@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        jmorris@namei.org, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220411163446.o3el6pxxsla2564a@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
 <YlAUj6w6fePEo7v+@hirez.programming.kicks-ass.net>
 <93b08ed3-80ca-4171-aaed-1513ae7cb0e1@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93b08ed3-80ca-4171-aaed-1513ae7cb0e1@linux.microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:47:46PM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 4/8/22 05:55, Peter Zijlstra wrote:
> > On Thu, Apr 07, 2022 at 03:25:09PM -0500, madvenka@linux.microsoft.com wrote:
> > 
> >> [-- application/octet-stream is unsupported (use 'v' to view this part) --]
> > 
> > Your emails are unreadable :-(
> 
> I am not sure why the emails are unreadable. Any suggestions? Should I resend? Please let me know.
> Sorry about this.

That was actually my (company's) fault when I bounced the patches to Peter.

-- 
Josh

