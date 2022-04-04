Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464334F15CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351411AbiDDN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiDDN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:26:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8078BF4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:24:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q200so7552209qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dj909oRaNRb7301+COOAr97OsAL18eivV1Pl1t4/Y+Y=;
        b=R2BOiI73bs4bhzycM+H031R9LnpSNDl9hKlfXb/Dsoc/YoMnaNNRKuQM34krIxm7bA
         UdsRcGSrXdyKB/quZlwiHCdQaKXaV+f12rnrSF+IMmSYVRVeRgWOr1Rs7fay6xmOVLY8
         gSTwID3IsnJpPaf4UShy9BcWjNLRqILCMZ+ILJ3BbBwQLna9/74cnfwKsp8+RXQ6WYz9
         dITlk4nDyLpanZaCHbh4P8ed9NWhbgc+yoMtAyXPlBDSHqcsPyowJ4JOOSG3rDrQZvfw
         sFTcXv/Ie18QUyJRu8j5PZ+bBcdiGYnl/hzo2dqUc/Yc3Pwe1Ut+ImfYz41fTLY4VEPS
         sT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dj909oRaNRb7301+COOAr97OsAL18eivV1Pl1t4/Y+Y=;
        b=8JJO1VagTtySTKI1xARiU4cbqzIygDROW9/97ElmxK4hxHNgHdpuLWhaDNJetpjvXW
         qi57n36sPxL7W/eP9jprPiEcEfZBB1yL/pmirFsJjPZJVgRmnpDv2P5yJ9xlZlqvLEN0
         bAMLK7uvF9iyKcIVYejLy1B8S43zjyhNX/WPULJBgjE67vKM/Ug8phFQbEvEcYixDWRq
         u2hcrg1j0PbqMUPb9mNywC4NUerdP9eM46IeUd7gA7Y46T5GE2n0mArPYkARlJOdyD/G
         NmP71tQoaw3w6FQ8ICpYuzmCIz1W5OcfCqZb8ZCnYctBya95oRY48HHrWcRCIJp4HVYg
         o9oQ==
X-Gm-Message-State: AOAM532YHObsEFrwLeItdzmtSLI12Xg+pui68XkXtADgavflcLhtqzi3
        LiQKkZ6AL0DI7QkU/d4+0xrG/g==
X-Google-Smtp-Source: ABdhPJwd0cXQeoez8xJ261ZBrwRTk36GjcX534AnDsLUP+ScvuOwmJyyalnuuG5orGBA0Q0zQDNBsg==
X-Received: by 2002:a37:c4c:0:b0:67b:2b35:762 with SMTP id 73-20020a370c4c000000b0067b2b350762mr13415114qkm.6.1649078647740;
        Mon, 04 Apr 2022 06:24:07 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm6476475qkf.40.2022.04.04.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:24:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nbMgf-00CAIu-Pe; Mon, 04 Apr 2022 10:24:05 -0300
Date:   Mon, 4 Apr 2022 10:24:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marc Zyngier <maz@kernel.org>
Cc:     xieming <xieming@kylinos.cn>, sashal@kernel.org,
        catalin.marinas@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        will@kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kvm/arm64: fixed passthrough gpu into vm on arm64
Message-ID: <20220404132405.GQ64706@ziepe.ca>
References: <20220401090828.614167-1-xieming@kylinos.cn>
 <87tubcbvgk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tubcbvgk.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:48:59PM +0100, Marc Zyngier wrote:

> NAK. For a start, there is no such thing as 'write-combine' in the ARM
> architecture, and I'm not convinced you can equate WC to Normal-NC.
> See the previous discussion at [1].
> 
> [1] https://lore.kernel.org/r/20210429162906.32742-1-sdonthineni@nvidia.com

We've had a lot of discussions with ARM related to how this works with
drivers like mlx5 that use WC.

ARM has now published some guidance on this:

https://community.arm.com/arm-research/m/resources/1012

As an ecosystem we seem to be drifting toward Normal-NC for this
behavior (largely because it is what Linux does). At least that is
what we are testing and qualifing ARM CPUs against mlx5 with.

I'm guessing it will turn into a SBSA like thing where the ARM ARM is
kind of vauge but a SOC has to implement Normal-NC in a certain way to
be functional for the server market.

Jason
