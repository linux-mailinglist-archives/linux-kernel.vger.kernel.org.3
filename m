Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD051338C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbiD1MZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbiD1MZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:25:42 -0400
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net [195.74.38.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AA23141
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:22:24 -0700 (PDT)
X-Halon-ID: d7f92a51-c6ed-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from [192.168.0.25] (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id d7f92a51-c6ed-11ec-9627-0050569116f7;
        Thu, 28 Apr 2022 14:22:19 +0200 (CEST)
Message-ID: <3ab60c35-a207-287d-32fc-a958d0e33230@gaisler.com>
Date:   Thu, 28 Apr 2022 14:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] can: grcan: Bug fixes
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
References: <20220427134307.22981-1-andreas@gaisler.com>
 <20220428065058.mf76kmhamddsqsvk@pengutronix.de>
From:   Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20220428065058.mf76kmhamddsqsvk@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-28 08:50, Marc Kleine-Budde wrote:
> On 27.04.2022 15:43:04, Andreas Larsson wrote:
>> These patches
>> * makes sure that DMA memory is allocated properly
>> * avoids the tx errata workaround needlessly being applied
>> * fixes a bug where the driver can be left hanging without interrupts enabled
>>
>> Andreas Larsson (2):
>>    can: grcan: Fix broken system id check for errata workaround needs
>>    can: grcan: Only use the napi poll budget for rx
>>
>> Daniel Hellstrom (1):
>>    can: grcan: use ofdev->dev when allocating DMA memory
> 
> Thanks for the patches. Can you please add a "Fixes:" tag to each patch.
>  From the description it seems they should be backported to the stable
> kernels, correct?


For patch 1 I can add a Fixes: that points to 53b7670e5735, which is the
patch after which the patch is needed (even though that commit is not
bad in itself, but merely exposes a wrongly used device pointer in the
grcan driver).

For patch 2 though I am not sure. I don't think the problem has always
been there, but I am not really sure what commit to point to. The fix is
at least needed for 4.9 and onward and 4.9 is the oldest stable branch
still under maintenance. Seems not to be worth the effort to find
exactly from which commit the grcan driver's quirky use of the napi
budget actually lead to problems just to make sure that it gets applied
to all currently maintained stable branches. Suggestions?

For patch 3 I can point to the driver's original commit for the grcan
driver as the problem has been there all along.

Cheers,
Andreas
