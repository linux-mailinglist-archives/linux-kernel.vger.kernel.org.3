Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967BA529BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiEQINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiEQIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8283CA5B;
        Tue, 17 May 2022 01:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8CAB81676;
        Tue, 17 May 2022 08:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA72FC34118;
        Tue, 17 May 2022 08:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652775114;
        bh=llNkl7VjoDFq45GE9zLRv3fM/rdlrqyTYZ0Se5GgTdo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UtSmDl9WNRGU0BI0/WBNJk0fMEnYSZXzY4F9kNiqfmN/mKUBJDNFK5zySt5d4RR+f
         dCsuRZ6NaYYyJTfcqgEu0o+eO5cQE6oOMQq/P3ppWwLfSa4ir2bUKkJbnKvRebhERZ
         ACWmtMNRJSI47E/uEWw8WTb8S3np8wK/hKoL+JqwLabjODlI3aqMUTB3i8LDNFk1d9
         kiHYXaw2sTdAmhSj18ZVzteVBAGIsEOHo4ksASJccQmrWzYv+slI7x9HdYgYOHdwa/
         /bZt3LL5ovU/Sgw6fd8r/uU0QJErFhGO+QxhBXVh2so0W35vsGr4f/BqneXwKgQd5t
         bkNbyss5hlqHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220426212136.1543984-1-bjorn.andersson@linaro.org>
References: <20220426212136.1543984-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4] clk: qcom: rcg2: Cache CFG register updates for parked RCGs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Tue, 17 May 2022 01:11:52 -0700
User-Agent: alot/0.10
Message-Id: <20220517081154.AA72FC34118@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-26 14:21:36)
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. For this, and similar, purposes the
> "shared RCGs" will park the RCG on a source clock which is known to be
> available.
> When the RCG is parked, a safe clock source will be selected and
> committed, then the original source would be written back and upon enable
> the change back to the unparked source would be committed.
>=20
> But starting with SM8350 this fails, as the value in CFG is committed by
> the GDSC handshake and without a ticking parent the GDSC enablement will
> time out.
>=20
> This becomes a concrete problem if the runtime supended state of a
> device includes disabling such rcg's parent clock. As the device
> attempts to power up the domain again the rcg will fail to enable and
> hence the GDSC enablement will fail, preventing the device from
> returning from the suspended state.
>=20
> This can be seen in e.g. the display stack during probe on SM8350.
>=20
> To avoid this problem, the software needs to ensure that the RCG is
> configured to a active parent clock while it is disabled. This is done
> by caching the CFG register content while the shared RCG is parked on
> this safe source.
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

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
