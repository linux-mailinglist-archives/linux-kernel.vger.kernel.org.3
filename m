Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F955C215
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiF0SAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiF0R76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:59:58 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39903B7CA;
        Mon, 27 Jun 2022 10:59:58 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h85so10376528iof.4;
        Mon, 27 Jun 2022 10:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XogYVUgT3W3Q8+7OypuWUvQY31VgP/RT9SPk1+m3+FU=;
        b=P1U5WA7glJBrsjBJuLAWdbBpoCGdAbSB/3LokD/2aLtZxdX/tUw6Nb05Q4uVYFSJ+Z
         gGLUlqB6c4Khwma9dEe9gvHDHfyhT91L2PYLjKQ94bneP0O5PCvNvmoFMggtYQasmMIH
         y2GxFpn6PrRGiofbD7V6loPG3ccC8Lk22jS8lSm6MIBmRJ+shSF2Y6O/tT88H6jvnSnb
         9cV1GCBVW+bREy/Y1syWTOvLJhoL/k5NdDal32SeNhXgIBfR0lO2KNEy0Mbr6zlT6WtX
         k1yd+QwTTsNfxIyFaV5WKnVkYEU5X4kZBneIR3ySTS2RkBmxgmrMJcFvmElzhedgXIfY
         Ue/A==
X-Gm-Message-State: AJIora8X2HMxP/FsDb8gyrFF0/cIZuQqGsrbnZtNO4nhBktHhmArifQ+
        tmxBUlvagW01fEG+lhdvE3F64g0A/A==
X-Google-Smtp-Source: AGRyM1vAnwCiFcCCYZPO4BGu1uNq+/KAgXdRX2IZdwF+ppESdewzYUfeD2cIKxI+ap3H/K+z1y5OaQ==
X-Received: by 2002:a5d:9a84:0:b0:675:51d2:f1cd with SMTP id c4-20020a5d9a84000000b0067551d2f1cdmr1367241iom.173.1656352797431;
        Mon, 27 Jun 2022 10:59:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x17-20020a056e020f1100b002d943793c68sm4849162ilj.56.2022.06.27.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 10:59:57 -0700 (PDT)
Received: (nullmailer pid 2674770 invoked by uid 1000);
        Mon, 27 Jun 2022 17:59:55 -0000
Date:   Mon, 27 Jun 2022 11:59:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Message-ID: <20220627175955.GA2665611-robh@kernel.org>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-2-frowand.list@gmail.com>
 <20220624141320.3c473605@fixe.home>
 <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:44:07AM -0500, Frank Rowand wrote:
> On 6/24/22 08:13, Clément Léger wrote:
> > Le Thu, 23 Jun 2022 22:43:26 -0500,
> > frowand.list@gmail.com a écrit :
> > 
> >>  
> >> +/*
> >> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
> >> + * scripts/Makefile.lib
> >> + */
> >> +extern void *__dtb_empty_root_begin;
> >> +
> >>  /*
> >>   * of_fdt_limit_memory - limit the number of regions in the /memory node
> >>   * @limit: maximum entries
> >> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
> >>   */
> >>  void __init unflatten_device_tree(void)
> >>  {
> > 
> > Hi Frank,
> > 
> > This function is only defined when CONFIG_OF_EARLY_FLATTREE is enabled.
> 
> More precisely, only if CONFIG_OF_FLATTREE is enabled.  But that would
> most likely be seleved by CONFIG_OF_EARLY_FLATTREE, so in practice the
> issue you raise is valid.
> 
> > Which means that on platforms that do not select this, the default
> > empty device-tree creation will not be done.
> 
> Yes, so platforms that need this functionality need to select this
> option.
> 
> > 
> > This configuration option is selected by the platform and not by the
> > user. On x86, only one config enables this (X86_INTEL_CE) which means
> > this won't work on all the other platforms even if CONFIG_OF is
> > selected. I would need this to work by only selected CONFIG_OF.
> 
> Maybe this means that CONFIG_OF should be changed to select
> CONFIG_OF_FLATTREE.  Any opinions on this Rob?

I don't think that works in the PDT (Sparc) case.

I think either CONFIG_OF_FLATTREE or CONFIG_OF_EARLY_FLATTREE will need 
to become user selectable.

> 
> > That's why I decided to add the of_root creation in of_core_init()
> > using a function (of_fdt_unflatten()) that is provided if CONFIG_OF is
> > defined.
> 
> I mentioned this in response to the previous patch series, but will
> repeat here for those who might not have read that email thread.
> 
> I do not want the root live tree to be created buy different code in
> different places; I want one central place where this occurs.  When
> the tree can be created in multiple places by different code blocks,
> it becomes more difficult to understand the code and more likely that
> one of the tree creation code blocks is not updated when another is.

+1

Rob
