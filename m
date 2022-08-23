Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231059EA82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiHWSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiHWSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:05:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A0EA8BE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:12:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DE2968AA6; Tue, 23 Aug 2022 18:12:55 +0200 (CEST)
Date:   Tue, 23 Aug 2022 18:12:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Tal Lossos <tallossos@gmail.com>, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme: NULL pointer dereference in nvmet_setup_auth
Message-ID: <20220823161255.GA21462@lst.de>
References: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:23:37PM +0300, Tal Lossos wrote:
> Hello,
> There is a NULL pointer dereference in nvmet_setup_auth() introduced
> in commit db1312dd95488b5e6ff362ff66fcf953a46b1821 causing a DoS.
> As of v6.0-rc2, in target/auth.c:196, if there is an error with
> ctrl->ctrl_key, it gets reassigned to NULL, and one line afterwards,
> it gets dereferenced in the call for pr_debug():

Hannes, can you look into this?

> 
> ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
>     host->dhchap_ctrl_key_hash);
> if (IS_ERR(ctrl->ctrl_key)) {
>     ret = PTR_ERR(ctrl->ctrl_key);
>     ctrl->ctrl_key = NULL;   <--- Assigning NULL
> }
> pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> ctrl->ctrl_key->hash > 0 ?   <--- NULL pointer dereference
> nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> 
> This bug occurs probably due to a missing goto statement (goto out_unlock).
> 
> Best Regards,
> Tal Lossos
---end quoted text---
