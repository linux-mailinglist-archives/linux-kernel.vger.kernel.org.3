Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C559F71A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiHXKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiHXKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:06:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE880511
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661335602; x=1692871602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5H2XGxKIViXlQJqHwM3XIsaEV8LVgYD9dTobZ3g4NgE=;
  b=dlqRJ0S/6K9XWmOOXkWWpvgVoxtyAR2wHJgRc3sOqQtSTnjtwHJYip5M
   pTXSyK8dVT6hayzTsUuLvpivBqfXxFvqmkjHF/dx2hn+O1b5ra60Ek5au
   moJtiXQaYebUAkLJ7MLiguBtEcpIrt880kz43nhy2aimT+omdzqvGxidc
   q2VJJXAxEQxg6UC9gQJkLTKmqwlFKV0DHeuNtcldFRe3Q6vHzXaHedo1A
   p01RCQH9VCaNxeHTYBwzU6LkH3d5gO1AJNz9anLNw/f4qC/qFD+vRTu6X
   EbBILDbNCC91AJ+thQkdwgFRDqOh9GWYrT6y7x5+e5SdVrI8ayr+ZgK+J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355654532"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="355654532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670438355"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.11.141]) ([10.213.11.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:06:35 -0700
Message-ID: <4ee8c6f9-a8e1-c1e3-b3a0-b45457157a86@intel.com>
Date:   Wed, 24 Aug 2022 12:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v9 1/8] overflow: Move and add few utility macros into
 overflow
Content-Language: en-US
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@linux.ie,
        daniel@ffwll.ch, andi.shyti@linux.intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com,
        intel-gfx-trybot@lists.freedesktop.org
References: <20220824084514.2261614-1-gwan-gyeong.mun@intel.com>
 <20220824084514.2261614-2-gwan-gyeong.mun@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220824084514.2261614-2-gwan-gyeong.mun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.08.2022 10:45, Gwan-gyeong Mun wrote:
> It moves overflows_type utility macro into overflow header from i915_utils
> header. The overflows_type can be used to catch the truncaion (overflow)
> between different data types. And it adds check_assign() macro which
> performs an assigning source value into destination ptr along with an
> overflow check. overflow_type macro has been improved to handle the signbit
> by gcc's built-in overflow check function. And it adds overflows_ptr()
> helper macro for checking the overflows between a value and a pointer
> type/value.
>
> v3: Add is_type_unsigned() macro (Mauro)
>      Modify overflows_type() macro to consider signed data types (Mauro)
>      Fix the problem that safe_conversion() macro always returns true
> v4: Fix kernel-doc markups
> v6: Move macro addition location so that it can be used by other than drm
>      subsystem (Jani, Mauro, Andi)
>      Change is_type_unsigned to is_unsigned_type to have the same name form
>      as is_signed_type macro
> v8: Add check_assign() and remove safe_conversion() (Kees)
>      Fix overflows_type() to use gcc's built-in overflow function (Andrzej)
>      Add overflows_ptr() to allow overflow checking when assigning a value
>      into a pointer variable (G.G.)
> v9: Fix overflows_type() to use __builtin_add_overflow() instead of
>      __builtin_add_overflow_p() (Andrzej)
>      Fix overflows_ptr() to use overflows_type() with the unsigned long type
>      (Andrzej)
>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v5)
> ---
>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
