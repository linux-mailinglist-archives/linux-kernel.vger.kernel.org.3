Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D7482C83
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiABSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:06:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39760 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiABSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:06:32 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A002B20140D;
        Sun,  2 Jan 2022 18:06:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 94C8480658; Sun,  2 Jan 2022 18:46:36 +0100 (CET)
Date:   Sun, 2 Jan 2022 18:46:36 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference
 in __nonstatic_find_io_region()
Message-ID: <YdHk/EH8LvusqRn+@owl.dominikbrodowski.net>
References: <20211130165925.194423-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130165925.194423-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Dec 01, 2021 at 12:59:23AM +0800 schrieb Zhou Qingyang:
> In __nonstatic_find_io_region(), pcmcia_make_resource() is assigned to
> res and used in pci_bus_alloc_resource(). There is a dereference of res
> in pci_bus_alloc_resource(), which could lead to a NULL pointer
> dereference on failure of pcmcia_make_resource().
> 
> Fix this bug by adding a check of res.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with ONFIG_PCCARD_NONSTATIC=y show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>

Although pcmcica_make_resource() will not fail, as the requested size is so
small: Applied to pcmcia-next.

Thanks,
	Dominik
