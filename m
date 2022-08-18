Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730BA598017
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiHRI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiHRI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:28:20 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFE9584
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:28:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660811295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmDACFAww771N8QDTZCRoxaYGKF8g2ZcH88LHpMyuOQ=;
        b=i4uEb4xT2CK5L/Y7PRLMc1NDACaYTmcgl7O+fTwj0efVvaC5BIkWasWWIr2OB3DVx3xZ3y
        y3Ifi+LMJIloPqAoSVDM1Fva9sR5PCHap83JuCcv7BKLjYajA4bbvKrUurUoLIz/2yKSPM
        s45TYx25iDkJwsGxBbITbsfZUI977HY=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present
 before accessing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 16:27:41 +0800
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A18421D4-7BD6-41E6-A284-846C4EF53B2F@linux.dev>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 15:37, Baolin Wang <baolin.wang@linux.alibaba.com> =
wrote:
>=20
> The pmd_huge() is used to validate if the pmd entry is mapped by a =
huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
> not get the correct pfn number for the non-present pmd entry, which
> will cause damon_get_page() to get an incorrect page struct (also
> may be NULL by pfn_to_online_page()) to make the access statistics
> incorrect.
>=20
> Moreover it does not make sense that we still waste time to get the
> page of the non-present entry, just treat it as not-accessed and skip =
it,
> that keeps consistent with non-present pte level entry.
>=20
> Thus adding a pmd entry present validation to fix above issues.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

