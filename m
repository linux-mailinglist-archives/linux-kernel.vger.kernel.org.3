Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB04E6BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357260AbiCYBYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiCYBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:24:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190DBD8A5;
        Thu, 24 Mar 2022 18:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5724B82726;
        Fri, 25 Mar 2022 01:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899FBC340EC;
        Fri, 25 Mar 2022 01:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648171351;
        bh=wsbD88OkQk6RA2UPPUVYj29mlvHLRNYOv+tOFG2E2wc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aXsjkxgAT9q8AR32d84qZxnvZOw6VPTp+57E0WruO1F8ae/1dPJQtfOiMY0KsvHd4
         RGRTOfxVGRvPNBevAMYGT/UgHx5Chj0HtXil0Kt2MDlhwgrpXPwr+48bqmQEPEghDp
         TLok6ARWoss753YbyWeIyjkyXVe5VDTXz2ykOOg1QoQR+8FLVn2fMxMxFmcyWuI6QP
         RmAiB7/HNSWDWUexZAJcrph6jaeeWbhf+4gULwTXWjhz+5h4QtYc+/QKjZ4/J1j9U3
         EnizVD5Prha2R5AL97ItmsjDnLhF2t1H+OT6rEGFAb8qmORbJZe45ZoEdz974cT73s
         hi+PImrYOzTfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-4-ansuelsmth@gmail.com> <20220325011037.03173C340EC@smtp.kernel.org> <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 24 Mar 2022 18:22:29 -0700
User-Agent: alot/0.10
Message-Id: <20220325012231.899FBC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-24 18:13:49)
> On Thu, Mar 24, 2022 at 06:10:35PM -0700, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-03-21 16:15:33)
> > > PXO_SRC is currently defined in the gcc include and referenced in the
> > > ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
> > > panic if a driver starts to actually use it.
> > >=20
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> >=20
> > What is this patch about? clk providers shouldn't be calling clk_get().
> >
>=20
> If pxo is passed as a clock in dts and defined as a fixed clock, what
> should be used?=20

clk_parent_data
