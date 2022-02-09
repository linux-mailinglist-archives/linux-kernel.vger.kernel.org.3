Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF534AF40A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiBIO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiBIO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:27:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD0C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:27:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED20D210DC;
        Wed,  9 Feb 2022 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644416858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR5usoKMTeoQ9+rrjJTPPrHXO3MKPTmuxZMkhS6HknU=;
        b=WZi6wXBd8VtH6Y/aG9E+es+ylcfvFlV2AQJD3PPMYz9DJdlIFRmYYaj10JbH9JWSivdFm+
        CLaFl41S9Xoi7C/e63VyDfL8bSMJ8ONuE2Rp3pWbTeWrAfJzPc4HnM7xM3ZQ0EAGuBlVHW
        vj1YUpKwrYsO12nd1tjfy5IQ7aUjmrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644416858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR5usoKMTeoQ9+rrjJTPPrHXO3MKPTmuxZMkhS6HknU=;
        b=rIBy35BFZzKYQh4bZOw8SSPa2Dlu02IuaN7R8LnqkQ4rC2/VEI6Bm7ZVjUplCeUH66bafG
        yt8cawKqD9In81CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCECD13A70;
        Wed,  9 Feb 2022 14:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0XtuLFrPA2KIaAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 09 Feb 2022 14:27:38 +0000
Date:   Wed, 9 Feb 2022 15:27:30 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v1] tmpfs: support for file creation time
Message-ID: <20220209152730.13f52fa2@endymion.delvare>
In-Reply-To: <20220205141233.GA938324@xavier-xps>
References: <20220205141233.GA938324@xavier-xps>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2022 15:12:33 +0100, Xavier Roche wrote:
> Various filesystems (including ext4) now support file creation time.
> This patch tentatively adds such support for tmpfs-based filesystems.
> 
> The reason is that creation time has been supported on an increasing number
> of filesystems (this information can be retrieved through the statx()
> userland function), and its support for tmpfs would add consistency.
> Example of use includes checking the creation time of an ephemeral status file
> being updated (such as a "work in progress" placeholder), to get two time
> points (starting point and last update).
> 
> Note that I am nothing but a new contributor, and while this patch has
> been tested (and userland results checked), the logic might be broken.
> 
> Signed-off-by: Xavier Roche <xavier.roche@algolia.com>
> ---
>  include/linux/shmem_fs.h |  1 +
>  mm/shmem.c               | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> (...)

Tested-by: Jean Delvare <jdelvare@suse.de>

Code looks reasonable, but take my review with a grain of salt as this
isn't my area.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
