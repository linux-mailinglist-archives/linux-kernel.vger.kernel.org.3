Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE24E9EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiC1SS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiC1SS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6A38D9A;
        Mon, 28 Mar 2022 11:16:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w8so15361284pll.10;
        Mon, 28 Mar 2022 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmQ8Pxzi+Z9l8ejBIWAmIqyy4Jpg692Mg7RREXlY2/Q=;
        b=dGhJRXlBShwg8AriQxi7fKU2M/J713BdphGZclZ0PJ7lZso9/8FinVzDhD/2f88oZj
         lbiwQiWzjjC94beyGKvUl3OJT4njdmwWj8JGcxL/8BCBTtueq1WUGspGKUP5nJsn7KrM
         yoc4qM9O0pcV+qhmWDkEpINspKieu994ykC6KiJttD146G4iSGuluqHql6PIO7U9SfhB
         GKKAYKImLaaddTWhIOwubiiMFq2tKM45hr5GS+CMbf9BoeMSnGKnIiPGMuh+834kHK5g
         ZBwBamOzMULQPlfd480rP8JnGbip+Z0/otTzlzae4VPtLreXqXv+HFGboddZZv6BVvlW
         8Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmQ8Pxzi+Z9l8ejBIWAmIqyy4Jpg692Mg7RREXlY2/Q=;
        b=GXbhHjUD6TL+kI0iuo1bukuy4mCj3c6YBrjFppPT8eazWnbfJ9TDHvJAGHLw71i3xB
         Kx+tEdC2VaNlEoDP4MsF+FRqvWbIUvtQQA8JvRmYm87/oOdwf9iKekfyThesyuakgLJ8
         q2b1i8SbsTtDmnMZpHEpEa2ulOPAAkBmq6uhOWWyDry7Y99K8uioWhKo5bBgkxJvXZa/
         0cQwlq28DA8xYxsT0uGyVG0EOSYaOdoXUFo24CTeUwQy4wy1E1KWK49gqypTNWVW8Mj6
         UNun1trbYlelBY5mWLDEBDgP/hBcjM35L/Jm/E1CKPKdsryteFlYsHU5jDot8LNJHx6q
         mDtA==
X-Gm-Message-State: AOAM533jmLFj6fEM4q3L585qCMlmEdPgH4hXMTa3ZoRHB+kVJw4YDlw+
        //G8smNBtpWxSz83NCbT/eE=
X-Google-Smtp-Source: ABdhPJxWp8Kjua4kmFMI6A6/fbdM9xNqeDSXQ1aUQW9gEwyiCKAt5OoXzGTXkfYMujWRpH8mSxuVIw==
X-Received: by 2002:a17:90b:4d87:b0:1c9:7f58:e5ca with SMTP id oj7-20020a17090b4d8700b001c97f58e5camr424499pjb.154.1648491404814;
        Mon, 28 Mar 2022 11:16:44 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm14081451pgn.83.2022.03.28.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:16:44 -0700 (PDT)
Date:   Mon, 28 Mar 2022 23:46:38 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: qcom-qspi: Add minItems to
 interconnect-names
Message-ID: <20220328181638.GA16448@9a2d8922b8f1>
References: <20220326212134.45759-1-singh.kuldeep87k@gmail.com>
 <42c32324-ce22-ae37-6118-35590f4e355c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c32324-ce22-ae37-6118-35590f4e355c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 09:21:34PM +0200, Krzysztof Kozlowski wrote:
> On 26/03/2022 22:21, Kuldeep Singh wrote:
> > Qualcomm QSPI DT spec says interconnects has minimum length 1 and
> > maximum length 2. Same configuration will be applicable for
> > interconnect-names. Schema currently depicts interconnects length
> > correctly but not interconnect-names. It can have a single entry, which
> > is a valid case yet to be incorporated in the current configuration. The
> > schema tries to look for 2 names and fail for DTs with a single entry.
> > Thus, add minItems property to interconnect-names to fix it.
> 
> Thanks for the patch.
> 
> 6 sentences which explaining the same, which could be written in one
> sentence. In the same time you actually do not explain whether having
> one interconnect is correct. You just say what DT spec says about
> interconnects, but maybe that's wrong.

Though commit desscription is subject to personal perspective, but I
also see some duplication here and will submit v2 with a shorter
description.

> 
> So either keep just one sentence or really explain why one or two are
> allowed (based on datasheet for example).

Please see commit 8f9c291558ea, interconnect properties were added by
one of maintainers of qcom-qspi. And it's been sometime this change is
in-tree with no regressions introduced. So, I don't think we should
double check this change. My change simply define minItem constraint to
interconnect-names which is already existing on interconnects.

-Kuldeep
