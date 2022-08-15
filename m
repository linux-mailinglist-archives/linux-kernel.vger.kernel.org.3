Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA5592FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiHONSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiHONSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:18:10 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F618358
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:18:07 -0700 (PDT)
Date:   Mon, 15 Aug 2022 13:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1660569485; x=1660828685;
        bh=m6uQKUSuYYtdaLvckje+IwGlC7pNQNCHt9cAc2AS6EA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=KVGreW3Kn50rjv9OxBASDevRa18VtkDnodKjJddCFkfeqKotP66DBr0/lWVudwGQ/
         PDF0oLsZTwE3nO2EQifZLwXkrMEovGwxbRBJ62Uj1nYP+vNEwv33fuzzKNCTou4yVv
         g2Hix1CuHtlrRDMivArDJgDDg771OrNW9gc2lQSM=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 1/3] input: add event codes for user programmable switch events
Message-ID: <70be22f4-7851-200b-9741-4032033f7bfc@connolly.tech>
In-Reply-To: <YvQyOhgSGjQLHHvv@google.com>
References: <20220516142158.1612109-1-caleb@connolly.tech> <YvQyOhgSGjQLHHvv@google.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2022 23:33, Dmitry Torokhov wrote:
> Hi Caleb,
>
> On Mon, May 16, 2022 at 02:22:57PM +0000, Caleb Connolly wrote:
>> Add SW_PROG{1,2,3,4} for device switches which are handled by userspace.
>>
>> This can be used for devices with "generic" switches which are intended
>> to be user-programmable, for example OnePlus phones contain a tri-state
>> key which can be used for switching between mute/vibrate/ring, or
>> programmed by the user to perform any arbitrary actions.
>>
>> These are analogous to the keys KEY_PROG{1,2,3,4} found on some
>> keyboards.

Hi Dmitry,
>
> This has been proposed a few times but this goes against the spirit of
> the input subsystem where each key or switch has a defined [default]
> purpose and userspace is normally expected to act upon input events
> without paying attention to what device they actually are coming from.
> IOW if you want to deal with particular GPIO signals you are better off
> using GPIO subsystem.
>
> In this context adding KEY_PROG1-4 was actually a mistake and we should
> try not extend it further.
>
> As fas as modeling the sliders with multiple settings goes I'd look into
> ABS events, probably ABS_MISC, with a set of values.

Ah I wasn't aware of ABS_MISC, this looks like a good way to go. Thanks.

>
> Thanks.
>
> --
> Dmitry

--
Kind Regards,
Caleb

