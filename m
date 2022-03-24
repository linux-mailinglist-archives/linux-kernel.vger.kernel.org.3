Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B944E6776
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbiCXRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346584AbiCXRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31FAB18A8;
        Thu, 24 Mar 2022 10:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A612B824D1;
        Thu, 24 Mar 2022 17:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC6C340ED;
        Thu, 24 Mar 2022 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648141614;
        bh=ZDw+3izesL2vgyZeSm6CI/oUxoTlv6vJLD9ct8D7oYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2PotNKeoYZJjB9A6IF7QsqbM4/seux9QfK7sD07Q8N7amZ/y4wk1DNkt4aQdB1E9
         Nouod4FXw44GWk5W0RjJFGFGeYhfUzGDefN9YGnB0eAQZwCYleg9qIjljuQZL9tcJ6
         RThfsvE1pI9lXOPHQv/bRiWAjXPk7y+FEp2R5pY0=
Date:   Thu, 24 Mar 2022 18:06:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinlong Mao <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 01/10] Use IDR to maintain all the enabled sources'
 paths.
Message-ID: <YjylKhBslN+5sKRx@kroah.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
 <20220324121734.21531-2-quic_jinlmao@quicinc.com>
 <YjxjXnXAXVXfZqr/@kroah.com>
 <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78ff137-fc5e-ff00-0e57-91304288d860@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:23:19PM +0800, Jinlong Mao wrote:
> Hi Greg,
> 
> Thanks for your review.
> 
> On 3/24/2022 8:26 PM, Greg Kroah-Hartman wrote:
> > On Thu, Mar 24, 2022 at 08:17:25PM +0800, Mao Jinlong wrote:
> > > Use hash length of the source's device name to map to the pointer
> > > of the enabled path. Using IDR will be more efficient than using
> > > the list. And there could be other sources except STM and CPU etms
> > > in the new HWs. It is better to maintain all the paths together.
> > > 
> > > Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-core.c | 75 +++++++-------------
> > >   1 file changed, 26 insertions(+), 49 deletions(-)
> > Your subject line is odd.  Please put back the driver subsystem in the
> > subject line so that it makes more sense.
> I will update the subject in next version.
> > 
> > And how have you measured "more efficient"?
> 
> Using IDR would be better than doing a sequential search as there will be
> much more device  in future.

How many "more"?  Where does the trade off of speed for complexity help?
How much faster is this really?  You can't claim performance
improvements without any proof :)

thanks,

greg k-h
