Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909D747220B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhLMIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:00:40 -0500
Received: from verein.lst.de ([213.95.11.211]:46531 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhLMIAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:00:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6258768B05; Mon, 13 Dec 2021 09:00:31 +0100 (CET)
Date:   Mon, 13 Dec 2021 09:00:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] vmcore: Convert __read_vmcore to use an iov_iter
Message-ID: <20211213080031.GB20986@lst.de>
References: <20211213000636.2932569-1-willy@infradead.org> <20211213000636.2932569-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:06:35AM +0000, Matthew Wilcox (Oracle) wrote:
> +	/* trim iter to not go beyond EOF */
> +	if (iter->count > vmcore_size - *fpos)
> +		iter->count = vmcore_size - *fpos;

Nit: iov_iter_truncate()

Otherwise this looks good from a cursory view.
