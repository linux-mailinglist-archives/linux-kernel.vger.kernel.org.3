Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CDE55E3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbiF1ND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbiF1NDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:03:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42932F666
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:03:52 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f14so9585451qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RfTPOLA/b2n52+mjjXM2dhhI51g7dFYPV2V5TbPKmas=;
        b=WaSHRYE2hvuxQmsWc0SvnAN4tiv17MiK+3qy6zaDnTIdcQqzxaiZOpv6wpmImsYmfY
         kmjqWCQO79upp4IaX63rXkjNOKGzHSWeTRUXqL0D+/iNuSouuvMslXtp+gPHE8u+coBw
         45tqt1TN3TyriiJX6+WIRH0eSBXoS8Jk9QfghYLxetn37BTcuB9V0BAG9GB7jpvFrAM/
         /rgR5zg9MsdA6MhHKh3WdZBib/rY/YR5rIPrzZKmWKrUiTF/gShfs8/JfDX3h9SlcTex
         GzPm3cCe+rQrhQ/QyyXd3oHXazXphIB822tgHiCAQyRU2GYpaXR1IwQV13sdu2taTEdX
         zkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfTPOLA/b2n52+mjjXM2dhhI51g7dFYPV2V5TbPKmas=;
        b=DvypPYpaswd9RwoaM07LyveXRr9487gdmoG2qBOzA3+x2PdPy/bdpMRV6lwi105meb
         eTTIjDjjP24wbeUGGMiXBJsqnHRj/rX+D0duw2JbVt7Yqh/Z+FI/38HzVdJ9E+zdrLxq
         5na2drvB3ZQiozAx/AtNOJrkPoT2aBK48EijSguNHloaiNL5sZhd49VmvKxM3sJmUjDP
         yJTx2KU4xYEgxEYKuGPFLs5cQ47LU3WpjZlkX9fuOazrLpxv7Nu5djngeyGaO3bwXs6G
         lRAjqnkTXCEScR7tDrWaYrIzH9fs4cZBYDHZwu7TMMbmWZ51H3ahdB65ohLgs0irPit7
         8DJQ==
X-Gm-Message-State: AJIora9y+T+CqHebquy7g+lVAx2oMP1WjqBVUFD2Hsb/Yp0tWNEpGk69
        qObuy5MyyYoYykhIKG2aZCVwIw==
X-Google-Smtp-Source: AGRyM1uHEMhM9NkhBpa9Cto8d3fMzuKczLR2QRFpR4+30YVcHeHk6+62HxsdfVF+jCXWw8m9EvdQwA==
X-Received: by 2002:a37:a815:0:b0:6ae:e677:d56e with SMTP id r21-20020a37a815000000b006aee677d56emr11125041qke.722.1656421431593;
        Tue, 28 Jun 2022 06:03:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w11-20020a05622a190b00b003162a22f8f4sm3962969qtc.49.2022.06.28.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:03:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6Asg-002uOb-2L; Tue, 28 Jun 2022 10:03:50 -0300
Date:   Tue, 28 Jun 2022 10:03:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        lizhe.67@bytedance.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH] vfio: remove useless judgement
Message-ID: <20220628130350.GN23621@ziepe.ca>
References: <20220627035109.73745-1-lizhe.67@bytedance.com>
 <20220627160640.7edca0dd.alex.williamson@redhat.com>
 <7217566f-9c40-ae9d-6fd6-2ef93f13f853@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7217566f-9c40-ae9d-6fd6-2ef93f13f853@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:48:11AM -0400, Steven Sistare wrote:
> For cpr, old qemu directly exec's new qemu, so task does not change.
> 
> To support fork+exec, the ownership test needs to be deleted or modified.
> 
> Pinned page accounting is another issue, as the parent counts pins in its
> mm->locked_vm.  If the child unmaps, it cannot simply decrement its own
> mm->locked_vm counter.

It is fine already:


	mm = async ? get_task_mm(dma->task) : dma->task->mm;
	if (!mm)
		return -ESRCH; /* process exited */

	ret = mmap_write_lock_killable(mm);
	if (!ret) {
		ret = __account_locked_vm(mm, abs(npage), npage > 0, dma->task,
					  dma->lock_cap);

Each 'dma' already stores a pointer to the mm that sourced it and only
manipulates the counter in that mm. AFAICT 'current' is not used
during unmap.

> As you and I have discussed, the count is also wrong in the direct
> exec model, because exec clears mm->locked_vm.

Really? Yikes, I thought exec would generate a new mm?

> I am thinking vfio could count pins in struct user locked_vm to handle both 
> models.  The user struct and its count would persist across direct exec,
> and be shared by parent and child for fork+exec.  However, that does change
> the RLIMIT_MEMLOCK value that applications must set, because the limit must
> accommodate vfio plus other sub-systems that count in user->locked_vm, which
> includes io_uring, skbuff, xdp, and perf.  Plus, the limit must accommodate all
> processes of that user, not just a single process.

We discussed this, for iommufd we are currently planning to go this
way and will See How it Goes.

Jason
