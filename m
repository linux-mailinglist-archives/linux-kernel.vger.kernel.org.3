Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A82495043
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiATOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:34:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348319AbiATOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:34:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2FB1F388;
        Thu, 20 Jan 2022 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642689243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7QZvgfmovRXKCVwJRDvreahMT4oFNvJVL9csHd2AmY=;
        b=V61k07tM9+FfVRRxeLwcpgxq7q5C/ItrveiK0teqVaCHwh24yhfRi7q01ZsV4+JfQ+or5E
        prD3GLjbAEqGOLyAScN2OBWplgSKAho2wBH+Neh3t71bG/9wgg4ugp46YsBKVAtCYalCTj
        b0ZeArRIH++QxVZteICY/6Ki6Y6RPuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642689243;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7QZvgfmovRXKCVwJRDvreahMT4oFNvJVL9csHd2AmY=;
        b=fDFrOTtM7hKmoHdem1Tor3swgWS3vn+sqcH8p8RxTKcBn9Hmq2j9jsu+dx2dmX381D6TBq
        kPOGwAGUow3xz8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6718C13BC6;
        Thu, 20 Jan 2022 14:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M7gkGdty6WGjIAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 14:34:03 +0000
Date:   Thu, 20 Jan 2022 15:34:02 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120143402.ihjacsucn3t7o3pi@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
 <Yelv5kTzQGOyucIS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yelv5kTzQGOyucIS@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:21:26AM -0800, Christoph Hellwig wrote:
> That looks quite old.  How does this look on mainline?

I am still try to reproduce it locally (on our SUSE kernels and
mainline). So far 'no luck' using nvme-fc. I'll try now with nvme-tcp
maybe it's transport thing.
