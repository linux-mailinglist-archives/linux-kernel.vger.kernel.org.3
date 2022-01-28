Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7144C49F983
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348527AbiA1Mgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:36:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348525AbiA1Mgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:36:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC291F3AA;
        Fri, 28 Jan 2022 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643373399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxTG5IMRJoMimLDfLpIFB/N5IQskYQQurM8B7Hm/hJg=;
        b=c6/xK0Lq83iY2gVJm+25k1bHd9EGQhZQMLemTSOy1Zbx5aQrmVDv4js2ppYIKz1ZgutY+F
        nAJl9FgpwP/0MrSNiH+X0LC8YlahC2oI3c1We0giygShW57jKHK4m9hb9f/COOqgAQhy8J
        bsspez8WjCTEDz+iOEnlg9HHmRqg+WA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643373399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxTG5IMRJoMimLDfLpIFB/N5IQskYQQurM8B7Hm/hJg=;
        b=ct9pX1x1w+Em4Vp8NnThnXBd7ZTibihBO6+kw0mMBmrpwCX3O9avwN3sCyxrizFNGqBaW/
        E9+RkUOplmefIdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D5C813A9F;
        Fri, 28 Jan 2022 12:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WpkhB1fj82FtYQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 28 Jan 2022 12:36:39 +0000
Date:   Fri, 28 Jan 2022 13:36:38 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220128123638.unxd5fzoctit6lpi@carbon.lan>
References: <20220127133648.8201-1-dwagner@suse.de>
 <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
 <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128103137.zugnrh2bbhkqpaoz@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:31:37AM +0100, Daniel Wagner wrote:
> On Thu, Jan 27, 2022 at 09:17:58AM -0800, Keith Busch wrote:
> > > +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> > > +{
> > > +	return ctrl->cntlid == 0xffff;
> > > +}
> > 
> > It's probably safe to assume 0xffff is dynamic, but spec suggests we
> > check ID_CTRL.FCATT bit 0.
> 
> Okay, but this one is only defined for fabrics. I haven't found anything
> so far which is equivalent to FCATT bit 0 for memory based transport.

Never mind. After discussing it with Hannes it turns out there is no
problem here. I didn't understand the spec correctly (it's difficult to
get an exact answer) on this topic.
