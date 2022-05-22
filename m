Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90055302C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiEVLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiEVLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:49:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1515FF2;
        Sun, 22 May 2022 04:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A349BB80AF8;
        Sun, 22 May 2022 11:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62DFC385AA;
        Sun, 22 May 2022 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653220150;
        bh=DQpkpsyyty5lU5glAQWkGYGLNU1ybDvumKMYKx96+Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ayYnnRK08GKJePYnThXmP9se4mCv3GE8CU8Xj05IZLCvNLCKhC8QKknbP99BiT3G4
         XR5Z8NNnsC2nN+50nkNhRS9fHI5STjxrTz50qsNVOjcN6KhZMVc3Jp+nQTq9MIeh4J
         FFSSwdLSq5y2n+N6fSBrHasVZRdy7lak+5PnXavXkkeAAsbOEaLzvaRvURIY6zL/Xs
         TUQyxOgtBu1JqBnfiqbI72AZzrPRczVmniWAYz1sYB/1jGDHovcB6rj043E+L3i7s5
         H27ILzdqv/q+WdXLW6hcDqwgb7g87ssEo0H+b3LGuCpyNFsvT5b9AP53CUdzMN+W7P
         0P1YFYy2is0yA==
Date:   Sun, 22 May 2022 12:57:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for texas dac121c081 to the dac5571
 driver
Message-ID: <20220522125755.099b5452@jic23-huawei>
In-Reply-To: <20220512140232.000078c1@Huawei.com>
References: <42db911c-5eba-0511-3e8c-8011a2a5b44a@axentia.se>
        <20220428204439.4ec2b4ae@jic23-huawei>
        <20220501190349.54aa48a3@jic23-huawei>
        <06546c40-639a-01e4-ed99-4895edfe8211@axentia.se>
        <20220512140232.000078c1@Huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 14:02:32 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 12 May 2022 10:59:48 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> > HI!
> > 
> > 2022-05-01 at 20:03, Jonathan Cameron wrote:  
> > > On Thu, 28 Apr 2022 20:44:39 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > >> On Mon, 25 Apr 2022 22:46:30 +0200
> > >> Peter Rosin <peda@axentia.se> wrote:
> > >>    
> > >>> Hi!
> > >>>
> > >>> The new chip works much like the other chips supported by the driver, so
> > >>> this is just adding another compatible to the list.
> > >>>
> > >>> Chenages since v1:
> > >>> - Guenter Roeck noticed elsewhere that my mail setup was botched and
> > >>>   that my patches were clobbered. Hopefully fixed. *blush*
> > >>> - added tags from Sean Nyekjaer and Rob Herring      
> > >>
> > >> Applied.  Thanks    
> > > 
> > > Backed out temporarily because they have crossed with a fix (that I'd
> > > forgotten about) and were requiring a non trivial merge in linux-next.
> > > 
> > > https://patchwork.kernel.org/project/linux-iio/patch/20220324234340.32402-1-laurent.pinchart@ideasonboard.com/
> > > 
> > > Hopefully that will get resolved in my upstream fairly soon and I can
> > > fix this one up whilst applying it myself.    
> > 
> > Looks like it might be time to bring this one in from the cold?  
> 
> Nearly.  I have a pull request out to Greg. Once he's taken that
> I'll fastforward the togreg branch to include the fix and
> can then apply this.

Now we are good. Applied to the togreg branch of iio.git and added the
tweak needed to provide data in the of_device_id table.

Unfortunately timing is against me this time, and unless the merge window
is delayed this is now 5.20 material.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > Cheers,
> > Peter  
> 

