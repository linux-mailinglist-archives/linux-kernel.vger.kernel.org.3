Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1549F74C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiA1Kbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:31:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50174 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiA1Kbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:31:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9705E210FF;
        Fri, 28 Jan 2022 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643365897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64ePvJZYZ4cwxg5EnUXMzmRNBcCOSpJpUMTnUtbyk/Y=;
        b=W6JtESqawXB3XcyfJe4qKyopRtdCMXvrCA/zD/5QWjmNmZ/qXIhUXbisdg3JZmtFFvGZ3K
        spfIHHV2xbOVrcJzknGqa/qJ6o1rCS62EyrDepDzvBOLJ40w6xnaIB/npn54yUYAdUaa9r
        oIVE7uTuQAnvuLNTC+XFegMcABR+5zQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643365897;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64ePvJZYZ4cwxg5EnUXMzmRNBcCOSpJpUMTnUtbyk/Y=;
        b=4Sz4stspe4sZFG3qXzdQboeK2jshKdjenoMnqVQ8oynaFHKe3Tj1/KdhUHwkmdzqHSq/jV
        dHYoBg/zNCxJ55Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88A9E13D17;
        Fri, 28 Jan 2022 10:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OuYsIQnG82HpHAAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 28 Jan 2022 10:31:37 +0000
Date:   Fri, 28 Jan 2022 11:31:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
References: <20220127133648.8201-1-dwagner@suse.de>
 <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:17:58AM -0800, Keith Busch wrote:
> > +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> > +{
> > +	return ctrl->cntlid == 0xffff;
> > +}
> 
> It's probably safe to assume 0xffff is dynamic, but spec suggests we
> check ID_CTRL.FCATT bit 0.

Okay, but this one is only defined for fabrics. I haven't found anything
so far which is equivalent to FCATT bit 0 for memory based transport.
