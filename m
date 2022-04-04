Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C954F1D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382971AbiDDVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380488AbiDDUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:18:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DC33EB0;
        Mon,  4 Apr 2022 13:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B0D6B819AD;
        Mon,  4 Apr 2022 20:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3A2C2BBE4;
        Mon,  4 Apr 2022 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649103411;
        bh=nYrjW11SMU4fva4wzJcQI6rU4ZAODE6Dnc/6xUWDrwk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r03TCHe87koltSy95nzVGTn/o5qX36NLGQzxGvOSILvh4dNeIKDlYTienq8RyTz0v
         lt2iBEqbgnxEg0ZprA3lhCRlSzrr6Jeppq7V6CEzgDGD8uYvHkeadhEc1hXXCLGTKu
         OjO93VbTrqrDESOj6v4GNkO2rJ9FNjnwlos08toc1t0Uh8nzLogsK/9PvqmYrSJA5d
         7tfhVIVl5Bo4bh/l1ZTy4ugKPpSFsX76S4Vv1B0VVFkESnzMeulD88bH+Jw/B2x/Gb
         ZS5p7Y+e/2dQrP0mu5aAZJ26hdk1lwGqz7a9ixJg9ZassUxiwhjukxhrbfVvmOgIhQ
         1n8oH9MX7i64g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220308040348.1340405-1-bjorn.andersson@linaro.org>
References: <20220308040348.1340405-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Amit Nischal <anischal@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Mon, 04 Apr 2022 13:16:49 -0700
User-Agent: alot/0.10
Message-Id: <20220404201651.0B3A2C2BBE4@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-03-07 20:03:48)
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. For this, and similar, purposes the
> "shared RCGs" will park the RCG on a source clock which is known to be
> available.
> When the RCG is parked, a safe clock source will be selected and
> committed, then the original source would be written back and upon enable
> the change back to the unparked source would be committed.
>=20
> But starting with SM8350 this fails, as the value in CFG is committed by
> the GDSC handshake and without a valid parent the GDSC enablement will
> fail.
>=20
> To avoid this problem, the software needs to cache the CFG register
> content while the shared RCG is parked.
>=20
> Writes to M, N and D registers are committed as they are requested. New
> helpers for get_parent() and recalc_rate() are extracted from their
> previous implementations and __clk_rcg2_configure() is modified to allow
> it to operate on the cached value.
>=20
> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as n=
eeded")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Sorry I've been delaying reviewing this patch. I'll review it in the
next couple days.
