Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58651C99F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385418AbiEETuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385403AbiEETuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37FD5EBC3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:46:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso4991668pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlYdaZj1ZllD0dqZ9JILFLLCIzKibd0Th5kenPcu9aU=;
        b=aLnCuVnkP07jOSRDPM+S773YWsrmKkKkSF2qL4GIA3sDV7OGXqW9QWr//JB/9x8hFw
         Us2MPLD00hj9Cga3n6gCUvuC/36r1HblFssD+8Gk9mQOx9srm7it2ep4f6NBtCJRI4Oo
         1ViRyd2gY/a019BGDDJ6YJRq6yoKRm7FKzw5aNj0Hwl07v57/RywR/gL5i6wYKAyYdKQ
         l2oSNqqrO8koCOOHCnvptPNc7cV88ElC3j2OEZ3ATqtiCDgVtzWjo4oW0250khQOen9/
         nspVZIPhhi7ZaUBwrjeHDGRjRkO6M8zZLbvEgXU4HJDfruoXyPKsYbuFmcWUCJkXrA9o
         l4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mlYdaZj1ZllD0dqZ9JILFLLCIzKibd0Th5kenPcu9aU=;
        b=I/L3QXUmTYAbKHpJuYenkkpY02VpMp4ijtVoIJGBf/48aNkxzLxl/dihwsaE6EoKvi
         vdXdRH6BY2Iy/IgtY9d8gODVNpuFmsFh4DeWj9mNrvPZc8mxG7Z8iLo94NwqS4xWeqAX
         r5ne7R3IrAjZ81FqtW+nlcnaa5b3vc1DCfup/qCPhNNnH9ZGhrPai6c0iv71jbVSGffc
         jgb6XzC8Xa/h6Ye49+iAM1mtJES2TMMhrVj06xOhMyMEvHKUjZM6F98IMTZ+OoGWo25q
         0Y4o7875ESOFQrR3YI+VTcrsA8nlpHS0b32NXKLjFNCrNRCRsjZ5TVIXoo/yJIIUQuuc
         mgkA==
X-Gm-Message-State: AOAM531ESO7SFyeF/kXy8t+UVCVKvuSDU+7B3j4QEDfLQbOgtsyWGGcT
        8Zx49AbBvCZgiv9LXgMns449xecRoHE=
X-Google-Smtp-Source: ABdhPJzI+UTWpFSWw2hr1h7hkYuPh/HbO7KcewTcu3rOSNtuFHoe+YLrW/XGHZyTYnEOvE3lVb8TTA==
X-Received: by 2002:a17:903:22cb:b0:15e:d715:1bd8 with SMTP id y11-20020a17090322cb00b0015ed7151bd8mr5766669plg.159.1651780008231;
        Thu, 05 May 2022 12:46:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id z12-20020a63330c000000b003c14af50629sm1652742pgz.65.2022.05.05.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:46:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 09:46:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YnQpplXhbUUB4wXl@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055431.3826852-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:54:27PM +1000, Imran Khan wrote:
> The decision to free kernfs_open_node object in kernfs_put_open_node can
> be taken based on whether kernfs_open_node->files list is empty or not. As
> far as kernfs_drain_open_files is concerned it can't overlap with
> kernfs_fops_open and hence can check for ->attr.open optimistically
> (if ->attr.open is NULL) or under kernfs_open_file_mutex (if it needs to
> traverse the ->files list.) Thus kernfs_drain_open_files can work w/o ref
> counting involved kernfs_open_node as well.
> So remove ->refcnt and modify the above mentioned users accordingly.
> 
> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
