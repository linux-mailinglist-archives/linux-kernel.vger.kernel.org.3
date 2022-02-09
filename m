Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637AC4AF8C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiBIRsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiBIRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:48:39 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711DAC05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:48:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8151B68B05; Wed,  9 Feb 2022 18:48:37 +0100 (CET)
Date:   Wed, 9 Feb 2022 18:48:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 6/8] mm: don't include <linux/memremap.h> in
 <linux/mm.h>
Message-ID: <20220209174836.GA24864@lst.de>
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-7-hch@lst.de> <3287da2f-defa-9adb-e21c-c498972e674d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3287da2f-defa-9adb-e21c-c498972e674d@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:19:29PM -0500, Felix Kuehling wrote:
>
> Am 2022-02-07 um 01:32 schrieb Christoph Hellwig:
>> Move the check for the actual pgmap types that need the free at refcount
>> one behavior into the out of line helper, and thus avoid the need to
>> pull memremap.h into mm.h.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> The amdkfd part looks good to me.
>
> It looks like this patch is not based on Alex Sierra's coherent memory 
> series. He added two new helpers is_device_coherent_page and 
> is_dev_private_or_coherent_page that would need to be moved along with 
> is_device_private_page and is_pci_p2pdma_page.

FYI, here is a branch that contains a rebase of the coherent memory
related patches on top of this series:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pgmap-refcount

I don't have a good way to test this, but I'll at least let the build bot
finish before sending it out (probably tomorrow).
