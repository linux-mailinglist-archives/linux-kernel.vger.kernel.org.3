Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDE4DA4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351901AbiCOVbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350379AbiCOVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:31:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C15BE4B;
        Tue, 15 Mar 2022 14:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19EA3B81892;
        Tue, 15 Mar 2022 21:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E47C340F4;
        Tue, 15 Mar 2022 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647379830;
        bh=Z+w7qmmwtApw9A0X4lTrxH73AXRGI1t4uG6akIL9azM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M4PwMSDorSTfdtY0s/1gMPAGwA76o8BVklHp8cUpOsLR/WrS9AYZ0xQbOt88TuQaH
         EMQbSpPCoHfLXrEwj2M+QFhUoVpxT++T84P/S7tTMMZOvurhsiRzOWIGXE3vASsh+e
         36FI6P9cehMnn4n2+l4rzhjFAqEy35TiQWb3azA3bsUcQzWn2u1GgsQhcX2nilHAfS
         eF4egGjPLjkS4eVKhpZ2+lctYADUqew2oGAyw1mE8bswn940YdxDiTyWOZ3pAMwYVG
         +7xrwSWWJ8yHK8a6zeB47BABudr8r8ppqzsH7d+muharC6MX2YyZZNiwVPyxJ/RmZN
         4tKFqn7Jr7fVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YjDV3n1Xq/EGWU1E@Ansuel-xps.localdomain>
References: <20220313190419.2207-1-ansuelsmth@gmail.com> <20220313190419.2207-2-ansuelsmth@gmail.com> <20220315175520.32E1AC340EE@smtp.kernel.org> <YjDV3n1Xq/EGWU1E@Ansuel-xps.localdomain>
Subject: Re: [PATCH 01/16] clk: permit to define a custom parent for clk_hw_get_parent_index
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 15 Mar 2022 14:30:28 -0700
User-Agent: alot/0.10
Message-Id: <20220315213030.C8E47C340F4@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-15 11:07:26)
> On Tue, Mar 15, 2022 at 10:55:18AM -0700, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-03-13 12:04:04)
> > >   */
> > > -int clk_hw_get_parent_index(struct clk_hw *hw)
> > > +int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent)
> >=20
> > Please introduce another API vs. tacking on an "output" argument to this
> > API. That makes the patch less invasive. And it can also return a
> > pointer instead of an integer in that case.
> >
>=20
> Any suggestion about the name? clk_hw_fetch_parent_index? That would be
> a direct access of the internal clk_fetch_parent_index.
>=20
> The name is already not that intuitive as is. The alternative is to make
> it extra long, don't know if that's a problem...
> Something like clk_hw_get_parent_index_by_parent? (that is even more
> confusing)

Haha that's a mouthful. clk_hw_get_index_of_parent()? I realize now that
I misread the API because parent wasn't a const pointer. Please make
parent argument const as well and return an int as before.
