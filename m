Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432B59C93F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiHVTtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiHVTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:49:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2D33A3A;
        Mon, 22 Aug 2022 12:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37216B812A3;
        Mon, 22 Aug 2022 19:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B9AC433C1;
        Mon, 22 Aug 2022 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661197749;
        bh=RZpX33SQG/uaVlRMoFcxzWwH5bvWTFtzv9I8YsCSbE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+VD/QLyJ92ZHhvqcfdQKu2Qc5w83Eo+uwDBdycXuPumZoT7FaBfATXrjIOkxM2Jp
         Wx6elk7eJvxUOiOKtqIRE79BMjJpV87lH8afcA7LBTtZZ0xEyPGKfwZzMIUV9fgiPa
         BUKxprIFsdAcbJEaoLM4j1+jxlHvN4aWvzFK1njZpPgXtxn0xviCP2FLa8uBQlOrSu
         9yJ/SCu9y37LjhjATOF1YrStPG0XHxtd4cfcE0yX3PeCQjH5DNFM37qN7aFF3JxB8X
         DfSz/+6d0O3+kKuMYCkcYF2AHupnssukCVbYmhGMCqh4SbA7xfkFjWp0VFyc8vsRRg
         O07nrRcJnJYPA==
Date:   Mon, 22 Aug 2022 20:14:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20220822201419.20149725@jic23-huawei>
In-Reply-To: <9482dea1-fd70-00a7-df4c-640772ea53b4@fi.rohmeurope.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
        <20220820122120.57dddcab@jic23-huawei>
        <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
        <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
        <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com>
        <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
        <103abfae-6c0d-9a2e-2d59-0da4c8be3eb4@gmail.com>
        <CAHp75VchPCHsBcx7mMoGUjz=s4hmfnO6t7DqtpWfg=aGrbo1Fg@mail.gmail.com>
        <9482dea1-fd70-00a7-df4c-640772ea53b4@fi.rohmeurope.com>
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


Interesting to see the different mental models used when reading code.

Overall I'm fine with either static within function or static outside
function depending on author preference + for short cases like this
I'm also fine with them on the stack.

Obviously can only speak for what I'll take into IIO!

Jonathan



