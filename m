Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1364B4E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiBNLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:25:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351289AbiBNLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:24:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6015E6A00A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:00:08 -0800 (PST)
Received: from [192.168.1.214] (dynamic-089-014-252-000.89.14.pool.telefonica.de [89.14.252.0])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AF9B20B96F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:00:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF9B20B96F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644836407;
        bh=LzQUiSc5Q+jJWlC0npjLvm4wYgqY7ldnlwETjOHKEr0=;
        h=To:From:Subject:Date:From;
        b=kOzN0uGTjUuvYDUlEkHVdCmFmh6Tb1/LjSTmXI/XZetqcloiyS4rm4DnkhK9X6Ago
         4Z01dvo2URzVvDyTd1n8IjTWSvDP5pBe7lESzwx+jSpAgX2tKAOuWRQGUR33J3bzyo
         i8nHS2LO1gpde5wnKUcVhI9l7HpuLchrm0bgdBeQ=
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?B?S2FpIEzDvGtl?= <kailueke@linux.microsoft.com>
Subject: xfrm regression in 5.10.94
Message-ID: <874b6461-07a7-1eeb-4e97-54d1be1c27fe@linux.microsoft.com>
Date:   Mon, 14 Feb 2022 11:59:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 5.10.94 these two xfrm changes cause userspace programs like Cilium to
suddenly fail (https://github.com/cilium/cilium/pull/18789):
- xfrm: interface with if_id 0 should return error
  8dce43919566f06e865f7e8949f5c10d8c2493f5
- xfrm: state and policy should fail if XFRMA_IF_ID 0
  68ac0f3810e76a853b5f7b90601a05c3048b8b54

I see that these changes are a reaction to
- xfrm: fix disable_xfrm sysctl when used on xfrm interfaces
  9f8550e4bd9d
but even if the "wrong" usage caused weired behavior I still wonder if it
was the right decision to do the changes as part of a bugfix update for an
LTS kernel.
What do you think about reverting the changes at least for 5.10?

Regards,
Kai

