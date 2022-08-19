Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65B59A7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352399AbiHSVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352340AbiHSVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD32DA98;
        Fri, 19 Aug 2022 14:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09071B8291D;
        Fri, 19 Aug 2022 21:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB9C433D6;
        Fri, 19 Aug 2022 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660944217;
        bh=jD8wMbn5vywW3dTrHP/uwOa8y3ujw4O2XI1suWJOkOY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uyLRrNxFRVxhyG1+gvQ5c+POB+jFrZcc7noNkA8RGrYKAo9hlR53eZTWnj1muJI9Q
         1I0TJTQMUZacKsMqGp/MiAOLPpPV9z/q55rLIq0NpcRAQZERLFdP8bvDn0ICdi2J7M
         ACIexEhh95yaLyF84WFZ99C4TM9dfPxCgnjuxq+uy0J/vpxGv6UuaUpv95HOxYDweo
         zpmplkf0Qp6zdEf1NR61pbweRarvDC7WAOKQNRj00dtpT6ClCOa8zfBIHKvqCdHe12
         90fDPg3/jBOcy/xWa310GY0FeVkn5vh0i7BnMPPb3HePMw93MUqrrhXp2CQs+OyOeI
         0rhGdOxxlxx+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <63d9211f-d5ce-562e-358a-50f26c7caf35@siemens.com>
References: <63d9211f-d5ce-562e-358a-50f26c7caf35@siemens.com>
Subject: Re: [PATCH] clk: ti: Fix reference imbalance in ti_find_clock_provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 19 Aug 2022 14:23:35 -0700
User-Agent: alot/0.10
Message-Id: <20220819212337.AECB9C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jan Kiszka (2022-08-08 15:26:58)
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> When a clock is found via clock-output-names, we need to reference it
> explicitly to match of_find_node_by_name behavior. Failing to do so
> causes warnings like this:
>=20

Is this superseeded by
https://lore.kernel.org/r/20220621091118.33930-1-tony@atomide.com?
