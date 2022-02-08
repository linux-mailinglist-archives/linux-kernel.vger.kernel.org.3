Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4B4AD79B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359216AbiBHLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354263AbiBHLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:23:36 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971AC03FED5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:23:30 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 8B816DB9038;
        Tue,  8 Feb 2022 12:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1644319403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=my5/8th5a1G7ebhyaPdVtVtFmJbJrOhNxNQVFvXgC40=;
        b=Fnhwtslj8SYrkR8v0r6PKFfWgEtB3HXbPMoKJXMvRmOemwUCnV61p8NyytmFYHIxsngfbx
        X6J0GZxqNznkUW8ewaCtXL4RgXBRrqb+incxzeMpQl4thLb8d+AOBKEcNWcQJ7mKr9JL9X
        QPzs5JWZ/G/ywB8xYdBUfoeEoMukvMM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Yu Zhao <yuzhao@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v7 00/12] Multigenerational LRU Framework
Date:   Tue, 08 Feb 2022 12:23:22 +0100
Message-ID: <2228442.ElGaqSPkdT@natalenko.name>
In-Reply-To: <YgJQeBUDaPbuDHi+@dhcp22.suse.cz>
References: <20220208081902.3550911-1-yuzhao@google.com> <4714886.31r3eYUQgx@natalenko.name> <YgJQeBUDaPbuDHi+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =FAter=FD 8. =FAnora 2022 12:14:00 CET Michal Hocko wrote:
> On Tue 08-02-22 11:11:02, Oleksandr Natalenko wrote:
> [...]
> > Is the patch submission broken for everyone, or for me only? I see raw
> > emails cluttered with some garbage like =3D2D, and hence I cannot apply
> > those neither from my email client nor from lore.
>=20
> The patchset seems to be OK both in my inbox and b4[1] has downloaded
> the full thread without any issues and I could apply all the patches
> just fine
>=20
> [1] https://git.kernel.org/pub/scm/utils/b4/b4.git

Thanks, b4 worked for me as well.

=2D-=20
Oleksandr Natalenko (post-factum)


