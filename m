Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61957BCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiGTR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiGTR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:28:01 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5B25C75
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=v1t3f4KTFuPQDL7xJBqlOgCj9/6+VGmrwvZLjxF9fMs=;
        b=qXVFseVDYh/fIo8lJDwlPszNkLV22RDOUQHwdInF7uhAR12eNLDwCLMm0PftRS/Kc4fv8SizWudzK
         Aer+jGS5n+Z0Raf2wqd8pFDLJr4iacQwSmkGwmWPmaEhadkb516jd/KgxD/Yrp4iYe8lGApCVJtP6s
         TdJYt/ZSsj7r2Et4JRiTzpTih2i10Y8A3YNsef218T+4HWAjPqRa55osOIzMS/fTG6c5D1xZR0dEfJ
         FjyLdDgik87oIMBYF7r/vMZsvfUZfWzL0PXnaFkjz6YbrrEN2da1sgEV3HhwKeeRhKns7ZHKS2rd0e
         tLw/GEAKoZCPAVWOUmV+awzB4fXN7/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=v1t3f4KTFuPQDL7xJBqlOgCj9/6+VGmrwvZLjxF9fMs=;
        b=kRofbQqSLtT0G05b00SP44vMd7W9TB2fo1fFnvNY3WDXRAYnMdRJxN1aYGhCpds6KYStM5KrR00uK
         cFkmKWeDQ==
X-HalOne-Cookie: 225c84a9b6b7c94f0e63521d9b21bd4f9044930d
X-HalOne-ID: 4b3f892e-0851-11ed-be7f-d0431ea8bb03
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4b3f892e-0851-11ed-be7f-d0431ea8bb03;
        Wed, 20 Jul 2022 17:27:56 +0000 (UTC)
Date:   Wed, 20 Jul 2022 19:27:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 2/4] drm/gem: rename GEM CMA helpers to
 GEM DMA helpers
Message-ID: <Ytg7G0NO475IbqF7@ravnborg.org>
References: <20220720153128.526876-1-dakr@redhat.com>
 <20220720153128.526876-3-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720153128.526876-3-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Wed, Jul 20, 2022 at 05:31:26PM +0200, Danilo Krummrich wrote:
> Rename "GEM CMA" helpers to "GEM DMA" helpers - considering the
> hierarchy of APIs (mm/cma -> dma -> gem dma) calling them "GEM
> DMA" seems to be more applicable.
> 
> Besides that, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
> requests to rename the CMA helpers and implies that people seem to be
> confused about the naming.
> 
> In order to do this renaming the following script was used:
> 
> ```
> 	#!/bin/bash
> 
> 	DIRS="drivers/gpu include/drm Documentation/gpu"
> 
> 	REGEX_SYM_UPPER="[0-9A-Z_\-]"
> 	REGEX_SYM_LOWER="[0-9a-z_\-]"
> 
> 	REGEX_GREP_UPPER="(${REGEX_SYM_UPPER}*)(GEM)_CMA_(${REGEX_SYM_UPPER}*)"
> 	REGEX_GREP_LOWER="(${REGEX_SYM_LOWER}*)(gem)_cma_(${REGEX_SYM_LOWER}*)"
> 
> 	REGEX_SED_UPPER="s/${REGEX_GREP_UPPER}/\1\2_DMA_\3/g"
> 	REGEX_SED_LOWER="s/${REGEX_GREP_LOWER}/\1\2_dma_\3/g"
> 
> 	# Find all upper case 'CMA' symbols and replace them with 'DMA'.
> 	for ff in $(grep -REHl "${REGEX_GREP_UPPER}" $DIRS)
> 	do
> 	       sed -i -E "$REGEX_SED_UPPER" $ff
> 	done
> 
> 	# Find all lower case 'cma' symbols and replace them with 'dma'.
> 	for ff in $(grep -REHl "${REGEX_GREP_LOWER}" $DIRS)
> 	do
> 	       sed -i -E "$REGEX_SED_LOWER" $ff
> 	done
> 
> 	# Replace all occurrences of 'CMA' / 'cma' in comments and
> 	# documentation files with 'DMA' / 'dma'.
> 	for ff in $(grep -RiHl " cma " $DIRS)
> 	do
> 		sed -i -E "s/ cma / dma /g" $ff
> 		sed -i -E "s/ CMA / DMA /g" $ff
> 	done
> 
> 	# Rename all 'cma_obj's to 'dma_obj'.
> 	for ff in $(grep -RiHl "cma_obj" $DIRS)
> 	do
> 		sed -i -E "s/cma_obj/dma_obj/g" $ff
> 	done
> ```
> 
> Only a few more manual modifications were needed, e.g. reverting the
> following modifications in some DRM Kconfig files
> 
>     -       select CMA if HAVE_DMA_CONTIGUOUS
>     +       select DMA if HAVE_DMA_CONTIGUOUS
> 
> as well as manually picking the occurrences of 'CMA'/'cma' in comments and
> documentation which relate to "GEM CMA", but not "FB CMA".
> 
> Also drivers/gpu/drm/Makefile was fixed up manually after renaming
> drm_gem_cma_helper.c to drm_gem_dma_helper.c.
> 
> This patch is compile-time tested building a x86_64 kernel with
> `make allyesconfig && make drivers/gpu/drm`.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

I did not spot any cases where the include looked like it is not needed,
so patch looks good.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
