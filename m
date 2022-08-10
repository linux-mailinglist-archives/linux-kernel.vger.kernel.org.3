Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C458F46D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiHJWdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiHJWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:33:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA977E037;
        Wed, 10 Aug 2022 15:33:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3486523pjf.2;
        Wed, 10 Aug 2022 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3j0nqNxIb4WWGt44FuKaH0AOkMYtek5yMvvRues8MRo=;
        b=WNVUzJhKmVU/WLkiU0oPj6rjE5i4uYu8VWBAktlaU4VU0KngmqNhCR6FvXt8ikr2TE
         bEfwXWr/m7C/sNICOBV2dFy94bYwTnB61nSVv+XIpYukc5ZF3NU08N7/4+bDX/M1QFfr
         RLop0eqI9mMNi+zobtHwlscn1mw9G101TRBNWcjINCL7w0N5AFI4YRsL5CnvARIPgtsQ
         XCM6y4a6kBHxcNIx8akdYQVo8s9a8OI29frAa3NKk5FKsqu2BXh0zbgxyVDgaCc24QQu
         /32plMf6LQCmruoLCCAtY05SFATwr6L887eTdYweipdA/Hg635MhSsPfK4//Ub90/+0k
         M9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3j0nqNxIb4WWGt44FuKaH0AOkMYtek5yMvvRues8MRo=;
        b=5mAqo3aVO9ddN65wIInKmw711Rug2JfbodYzzQagl9SxiA8Ah7KYsAXQxgzZXzNGR1
         s8j8NlMIcSUC/Ho1BR3N6RccbfGAXdiLZLi4XhAdflvdO7FfuAFcW2X8LnnxuvEgqdnn
         eK+kdUcoxlVu42fTcxjPmnqmmIGPYr+fV5lGqX3a/eYfZ033yEY4hmHrf9zaP3k8hqNX
         5kW6/Bh9FF4PChdrs/dfr3qdIW++QtsFSgfuEGB7NQxC3b4LybGnHemA1zKsFlBHlF22
         qqLzKwPKGHAXgdPpxlBB738e/EMQHW2yMwaNI2UDFnbDrJ+US9rm6aNbQxoRc1VZAsfk
         KZlw==
X-Gm-Message-State: ACgBeo03o2McMCbhR97o9U6rrLRpfuoQj6H8PLwBIonxaBVC7cXrzi0J
        0XkuukfSuDQPG6XUJg5FS/c=
X-Google-Smtp-Source: AA6agR6tM+sxdnBf95t4iIxceRkJDbs1v70HQiMHw/eMZ7bEAg2t6Bdtg/orTJMMD+SensuFznuTpQ==
X-Received: by 2002:a17:902:ed44:b0:16d:b1a2:f24 with SMTP id y4-20020a170902ed4400b0016db1a20f24mr29036608plb.145.1660170814282;
        Wed, 10 Aug 2022 15:33:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id y12-20020aa79aec000000b0052ce1737ee1sm2542174pfp.37.2022.08.10.15.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:33:33 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:33:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] input: add event codes for user programmable switch
 events
Message-ID: <YvQyOhgSGjQLHHvv@google.com>
References: <20220516142158.1612109-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516142158.1612109-1-caleb@connolly.tech>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On Mon, May 16, 2022 at 02:22:57PM +0000, Caleb Connolly wrote:
> Add SW_PROG{1,2,3,4} for device switches which are handled by userspace.
> 
> This can be used for devices with "generic" switches which are intended
> to be user-programmable, for example OnePlus phones contain a tri-state
> key which can be used for switching between mute/vibrate/ring, or
> programmed by the user to perform any arbitrary actions.
> 
> These are analogous to the keys KEY_PROG{1,2,3,4} found on some
> keyboards.

This has been proposed a few times but this goes against the spirit of
the input subsystem where each key or switch has a defined [default]
purpose and userspace is normally expected to act upon input events
without paying attention to what device they actually are coming from.
IOW if you want to deal with particular GPIO signals you are better off
using GPIO subsystem.

In this context adding KEY_PROG1-4 was actually a mistake and we should
try not extend it further.

As fas as modeling the sliders with multiple settings goes I'd look into
ABS events, probably ABS_MISC, with a set of values.

Thanks.

-- 
Dmitry
