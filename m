Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC752B908
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiERLjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiERLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:39:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC517909F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652873960; x=1684409960;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=rjF4zWNjVkRaA4u9AigM/0O/Su6Qa+NPXOPo2kzYSB0=;
  b=lvYRUVjPAVSsPE9bjm97wa2mcbS//HmsGFbSniL6Jy7jXvTqHRxzZwiO
   VLkuByxn7hgtkaju8B7N3k4119AUVovLBYF+pp2eQ9tw+37syA47prkPr
   PQYLYhNILNobUB+waivvuC468LfmPzZ/3eoSTTrQKzWIbJtoAL6BQ4zpY
   D1oqPDujPIif3tvlJs3P9CRveX71AjWTxHS91OLDRGvq89xJYmLIUnJSr
   vKSFgk+Y0voPD808jO5xx0Hfc8tnUuYDJuo+Myyc2dfi+XqbZs/OcB/sF
   KBxELdlWQlSu1KJCEpcPzZ6F2hbQk5sAjSNVCzjjKXPvkCZ5JebQf2r2i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271577950"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271577950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:39:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="626998272"
Received: from jwasiuki-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.47])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:39:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 11/11] drm/i915: Fix undefined behavior due to shift
 overflowing the constant
In-Reply-To: <YoSj9O/6yA0nn/xW@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-12-bp@alien8.de>
 <78e67e42-7e1e-e9fa-036d-441168100731@infradead.org>
 <YoSj9O/6yA0nn/xW@zn.tnic>
Date:   Wed, 18 May 2022 14:39:14 +0300
Message-ID: <87k0ajdq8t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, May 17, 2022 at 04:05:46PM -0700, Randy Dunlap wrote:
>>=20
>>=20
>> On 4/5/22 08:15, Borislav Petkov wrote:
>> > From: Borislav Petkov <bp@suse.de>
>> >=20
>> > Fix:
>> >=20
>> >   In file included from <command-line>:0:0:
>> >   drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function =E2=80=98intel_g=
uc_send_mmio=E2=80=99:
>> >   ././include/linux/compiler_types.h:352:38: error: call to =E2=80=98_=
_compiletime_assert_1047=E2=80=99 \
>> >   declared with attribute error: FIELD_PREP: mask is not constant
>> >     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
>> >=20
>> > and other build errors due to shift overflowing values.
>> >=20
>> > See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
>> > details as to why it triggers with older gccs only.
>> >=20
>>=20
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>=20
>> Is this merged anywhere?
>
> It's state is "new" in their patchwork:
>
> https://patchwork.freedesktop.org/patch/480756/

Basically we run all patches through CI before merging, and because only
one patch was sent to intel-gfx, the CI just sat waiting for the rest of
the series to arrive...

Anyway, didn't really like the changes in i915_reg.h, sent my version of
that and the rest separately [1].

> so I guess not yet.
>
>> It could/should at least be in linux-next so that other people
>> don't waste time on it.
>
> -ETOOMANYPATCHES I guess. :-\

Yeah, sorry about that.


BR,
Jani.

[1] https://patchwork.freedesktop.org/series/104122/


--=20
Jani Nikula, Intel Open Source Graphics Center
