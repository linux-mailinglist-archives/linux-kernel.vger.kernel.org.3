Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8E49A7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315717AbiAYCyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3407874AbiAYAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643070064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ntjy8+chLJCGytFKA8pelsB5b8BrXmYg/+6iLbMlUec=;
        b=NRI2RGiRoKkpeY+/Vz6gJ/rFEgGa7NH9YjtpjyKPw2ovKmHtEmkoulrPh9Vw8EPGgUSnQ6
        J1mGFCaQBM5zps74scpKQxnpq9dqcrEu95IpfW+xYZrydjOr9ncprIeu/wFkf70eSQm1i/
        jVvWr4tf+M2Gb/gZFLWKCDaCmb4xuAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-kfJhdSBqNVeQGWVao-GqBA-1; Mon, 24 Jan 2022 19:21:00 -0500
X-MC-Unique: kfJhdSBqNVeQGWVao-GqBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB341100CCF2;
        Tue, 25 Jan 2022 00:20:59 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3E05F90F;
        Tue, 25 Jan 2022 00:20:25 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id CDF2F424F088; Tue, 25 Jan 2022 00:20:25 +0000 (GMT)
Date:   Tue, 25 Jan 2022 00:20:25 +0000
From:   Alasdair G Kergon <agk@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm: introduce a no open flag for deferred remove
Message-ID: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
References: <20220124150209.22202-1-bgeffon@google.com>
 <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <CADyq12ykDCswWZw05OdyYfP-zT6afuhXbckii1m1egQ2fSwB4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12ykDCswWZw05OdyYfP-zT6afuhXbckii1m1egQ2fSwB4w@mail.gmail.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:25:47AM -0500, Brian Geffon wrote:
> Thank you for looking at this. There are a few reasons this might be
> useful, the first is if you're trying to speed up a graceful teardown
> of the device by informing userspace that this device is going to be
> removed in the near future. Another might be on systems where it might
> be worthwhile to not have users with CAP_DAC_OVERRIDE be able to open
> the device. The logic on this second case is that, suppose you have a
> dm-crypt block device which is backing swap, the data on this device
> is ephemeral so a flow might be to setup swap followed by dmsetup
> remove --deferred /dev/mapper/encrypted-swap. This will guarantee that
> as soon as swap is torn down the encrypted block device is dropped,
> additionally with this new flag you'll be guaranteed that there can be
> no further opens on it.
 
And is that the reason you propose this?
- You want a special exclusive 'one time open' device that 
  self-destructs when closed?

> No, this is fully backwards compatible with the current deferred
> remove behavior, it's not required. Additionally, since on the actual
> remove userspace would receive an -ENXIO already once the remove
> process has started it seems reasonable to return -ENXIO in the
> deferred remove case when this flag is enabled.
 
Well I feel it does break existing semantics which is why we wrote
the code the way we did.  The state can be long-lived, the code
that has it open might legitimately want to open it again in
parallel etc. - in general this seems a bad idea.

But if the reason for this is basically "make it harder for 
anything else to access my encrypted swap" and to deliberately
prevent access, then let's approach the requirement from that angle.
Are there alternative implementations with interventions at different
points?  Are there similar requirements for devices that don't need
deferred remove?  If this is indeed the best place to insert this type
of restriction, then we should label it and document it accordingly so
people don't mistakenly use it for the 'normal' case.  (We always keep
libdevmapper and dmsetup in sync with kernel interface extensions, so
we'd seek a tiny patch to do that too.)

Alasdair

