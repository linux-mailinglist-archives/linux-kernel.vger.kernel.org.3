Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADA59AD99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbiHTLkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiHTLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B499AFD4;
        Sat, 20 Aug 2022 04:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A79ECB80B8E;
        Sat, 20 Aug 2022 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC45C433D6;
        Sat, 20 Aug 2022 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995613;
        bh=EcUHd1SWLgvec3h1hgGjlCxBv5BJzZ8+dzXEcK4LL3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fbdj2EXsY4W47DuNQ5pBrs0wkqYfIttxu8Uh4cUt34F7eEj9+JPjk1XhmIArNQW0h
         ZEZaRC5IrMNyZuYPbb4TXco1qb4PmYHmoP92iECSX90nf7uWeMdrwJ5YLkgTwNnFHV
         aFmUP1mdqCLvJ53HKg62tbIWBY7Reu4MhuDzrPQUnuQoGnRS6+eJRhfijafW4pRNko
         yke3ohY7AmtQZskcC/mJqsgTjl2AQegCidWKjZBQOCtceF1LfFWigfmz/sa3ENAUVS
         K8Iow8bv7RaBwm+gkWRKkLX83Zw5tngJx2gl/F/WZOvDAmrNZz8oXjdoz2bHMSINAm
         Cf+46OVN2FN9g==
Date:   Sat, 20 Aug 2022 12:50:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Message-ID: <20220820125049.4e35e721@jic23-huawei>
In-Reply-To: <f56c7486-2b78-48ac-3c5d-c7c20d1e78f5@linux.ibm.com>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
        <20220809211246.251006-3-eajames@linux.ibm.com>
        <CAHp75VdbRiWxxbnW61SNdj+pC4skeRF3prXgPvKB+btjW3dLKw@mail.gmail.com>
        <f56c7486-2b78-48ac-3c5d-c7c20d1e78f5@linux.ibm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 08:59:03 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> On 8/12/22 17:13, Andy Shevchenko wrote:
> > On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:  
> >> Corruption of the MEAS_CFG register has been observed soon after
> >> system boot. In order to recover this scenario, check MEAS_CFG if
> >> measurement isn't ready, and if it's incorrect, reset the DPS310
> >> and execute the startup procedure.  
> > Looks like both patches miss the Fixes tag. Can you add them?  
> 
> 
> Well this isn't really a software fix - there's no identifiable bug in 
> the driver. Just trying to recover the chip in this observed mystery 
> scenario.

The tag is useful as well for where to backport this to.
Probably just tag the driver introduction.

Your description makes it clear we aren't finding faults in the
driver - just that it didn't cover this undocumented case!

Jonathan

