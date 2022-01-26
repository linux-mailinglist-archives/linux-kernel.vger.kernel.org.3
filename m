Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00149CBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiAZOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:11:57 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:58524 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiAZOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:11:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C0FB23F36F;
        Wed, 26 Jan 2022 15:11:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xl03J6hK3jv6; Wed, 26 Jan 2022 15:11:52 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CF3553F2DE;
        Wed, 26 Jan 2022 15:11:49 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.55.55.54])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A19CB3626AA;
        Wed, 26 Jan 2022 15:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1643206309; bh=LMhkrBdLZkCEhoHLd421DsjJY0iUDjhzCRAXtSuRAVw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bhGE/1T/HXW8ty3QjO7s0GAIEecumC7GzazfLWYDD2jQYG02G3lCi6TF9ppxG7z+d
         L8nfU6tWYcT5EHAEj2WlaO+dNC6RtJAjOqTwv4SegMhbcVhC3tAsjrlLS28INKx8vS
         0aYvFwy3m9W8Crjy6Y22md3wupm4M61QnUs9KDTU=
Message-ID: <db358c46-a34a-cc8d-e657-5a8d2b888034@shipmail.org>
Date:   Wed, 26 Jan 2022 15:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Intel-gfx] [PATCH v5 5/5] drm/i915/uapi: document behaviour for
 DG2 64K support
Content-Language: en-US
To:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org,
        Kenneth Graunke <kenneth@whitecape.org>,
        dri-devel@lists.freedesktop.org,
        Slawomir Milczarek <slawomir.milczarek@intel.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Simon Ser <contact@emersion.fr>,
        mesa-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220125193530.3272386-1-bob.beckett@collabora.com>
 <20220125193530.3272386-6-bob.beckett@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <20220125193530.3272386-6-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/22 20:35, Robert Beckett wrote:
> From: Matthew Auld <matthew.auld@intel.com>
>
> On discrete platforms like DG2, we need to support a minimum page size
> of 64K when dealing with device local-memory. This is quite tricky for
> various reasons, so try to document the new implicit uapi for this.
>
> v3: fix typos and less emphasis
> v2: Fixed suggestions on formatting [Daniel]
>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Acked-by: Jordan Justen <jordan.l.justen@intel.com>
> Reviewed-by: Ramalingam C <ramalingam.c@intel.com>
> cc: Simon Ser <contact@emersion.fr>
> cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Jordan Justen <jordan.l.justen@intel.com>
> Cc: Kenneth Graunke <kenneth@whitecape.org>
> Cc: mesa-dev@lists.freedesktop.org
> Cc: Tony Ye <tony.ye@intel.com>
> Cc: Slawomir Milczarek <slawomir.milczarek@intel.com>
> ---

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


