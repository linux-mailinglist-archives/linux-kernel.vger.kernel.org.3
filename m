Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AA462CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhK3GoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:44:16 -0500
Received: from verein.lst.de ([213.95.11.211]:57114 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233768AbhK3GoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:44:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A668568B05; Tue, 30 Nov 2021 07:40:54 +0100 (CET)
Date:   Tue, 30 Nov 2021 07:40:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
Message-ID: <20211130064054.GB10268@lst.de>
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com> <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com> <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:04:55PM +0800, luanshi wrote:
> Hi Keith,
>
> 在 2021/11/30 0:34, Keith Busch 写道:
>> On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
>>> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>>>     	lockdep_assert_held(&nvme_subsystems_lock);
>>>   +	if (strncmp(subsysnqn, "nqn.", 4))
>>> +		return NULL;
>> This seems like an arbitrary way to decide not to check for duplicates.
>> Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
>> broken controllers?
>
> Yeah, add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk is a way to resolve the 
> problem. I do not
>
> have enough controller in my hand, I don't make sure all the controller are 
> covered. And there are some

What does this broken device report in the subnqn field?
