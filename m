Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE224DA4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiCOVfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiCOVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F7BF57;
        Tue, 15 Mar 2022 14:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29681B810EE;
        Tue, 15 Mar 2022 21:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C4C340EE;
        Tue, 15 Mar 2022 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647380071;
        bh=8pwmfFxXgu9Kha0KZaWYb5XC+8kVZfHH2ATkleQcQTY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kGRJ98G7G3eTMa4RvJFbz/Ug9KZqoX9+/HnNFIQBHCGzm17ueens+ta8XGUWLgqKk
         n87XvbPMixk5WsO/cUOkjFr806yb2MWm+J2LyoJ0qpwKOyzXhZI1M8ItzScWaUCh8i
         TF3S3fcfRAS0uMkbnAq+VHXATqzCnrfMaoVpy5Xci3L+TMZ1MxUNN5ERE2Cy7brXBl
         bLtkmE3IFaz9QA/Pyuu19RHKeDzOx6k4yDJ6oYfXaiY3SFPmC+RIpPkVyqoszLwv4u
         JR0YIMIkoBXdoqQPIc+jfvn5ZmJKVGqwImSKINTJW4vYN9fLJY2LQElRsWl2mxCcG8
         hdDJtvJtHL2Bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-13-ansuelsmth@gmail.com> <169795c1-607e-ee60-7ac7-538ed888bedf@linaro.org> <Yi84aNrJ7p+3jy2A@Ansuel-xps.localdomain>
Subject: Re: [PATCH 12/16] clk: qcom: clk-krait: add 8064 errata workaround
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 15 Mar 2022 14:34:30 -0700
User-Agent: alot/0.10
Message-Id: <20220315213431.DB6C4C340EE@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-14 05:43:20)
> On Mon, Mar 14, 2022 at 11:20:21AM +0300, Dmitry Baryshkov wrote:
> > On 13/03/2022 22:04, Ansuel Smith wrote:
> > > Add 8064 errata workaround where the sec_src clock gating needs to be
> >=20
> > Could you please be more specific whether the errata applies only to the
> > ipq8064 or to the apq8064 too? 8064 is not specific enough.
> >
>=20
> That's a good question... Problem is that we really don't know the
> answer. This errata comes from qsdk on an old sourcecode. I assume this
> is specific to ipq8064 and apq8064 have different mux configuration.
>=20

I think it was some glitch that happened when the automatic clk gating
was enabled during a switch. The automatic clk gating didn't know that
software was running and switching the input so it killed the CPU and
stopped the clk. That lead to hangs and super badness. I assume it was
applicable to apq8064 as well because ipq8064 is basically apq8064 with
the multimedia subsystem replaced by the networking subsystem. Also I
wouldn't remember all these details because I worked on apq8064 but not
so much on ipq8064 :)
