Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45158B639
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiHFOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHFOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:51:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC4101CB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:51:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p8so4952997plq.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZHZGZq6h+lUo2eCrK9NN33tawRm/nou4eWvVvyVV5/g=;
        b=IBJCY8eQMmxSsTRzXC8fUR9mMTETadx7Dc7FFAwqZFyNrLd21rO/zwCCeRr3O4SsXU
         rRPG0BDeoL5+W0aNiX5rhkC+XKA8YS4/LZr5KxNs/6ngYmStUJPywy459UgvTwoTUCq8
         K3YDkmWP3h8cTknXLO8Ns0Sc9LPkFzKLyVYxZqRQtXVBBOdEegG5EtUs2PLPAUlPbRZy
         5FYEtkqxHT7QPWyUy3n7AsLfsjhjEI6FeqD2b1IUy4RmvjgaXdSnj8Vy/MWW4nJaITNY
         V3gfPD17xAHYLTAZ/0ihbLyddkJmNk7nChXr9zWbZf8dEOgL04rXZMclXiHMrHn50kB9
         8lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZHZGZq6h+lUo2eCrK9NN33tawRm/nou4eWvVvyVV5/g=;
        b=zpL54+KuA0JOiEY3nxgdja5w1o7KfXEoG7ui6lagZapWloTQZ0zbbaVp3FzCT7cRUv
         SsTS4rjMgEx4EnKuTyjR7Jo+L7TUJOW1Ma07tHzMkcPUWP5NSOEXJtWeGpA/wbficcmA
         7oWUsIFaJJ6JxuGjFxDjgmyXgQmmc49+h1NED6PE8n+uu6eNAbo3zGGYu99iFSC9hxUn
         JqAso7F66o+CWf29PNs572H/gYiqDyZszfFCrI5lRnV5REiNaMEoRZbwz+x50fiRkKlh
         9EIcIO9fpXzXbeLOIFe9ekY+gXAAuRD2vLj7Tj8kEOb3TbPdD6uz9UeET4ZQeqb2if3e
         At4Q==
X-Gm-Message-State: ACgBeo1Vxx6iXgzXHlHmmKuxa3wVdM1mXg4lp6+PhpYpZs3takFEUJ+p
        Uv4+Dnt5DQMloEP9vBxCZLWDag==
X-Google-Smtp-Source: AA6agR5tB1lfDWW5CK6g4gZATc2POoUrGVodj3DAFSvqGlbMXd9oczcdSfywNEA6LKlI4avxeOne+w==
X-Received: by 2002:a17:902:bd08:b0:16d:4230:cb45 with SMTP id p8-20020a170902bd0800b0016d4230cb45mr11344547pls.59.1659797514464;
        Sat, 06 Aug 2022 07:51:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o187-20020a625ac4000000b0052ef9556f47sm1527411pfb.40.2022.08.06.07.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 07:51:53 -0700 (PDT)
Message-ID: <026c2c04-aec2-0a8c-ed96-f31ae0918b2e@kernel.dk>
Date:   Sat, 6 Aug 2022 08:51:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND 1/1] loop: introduce LO_FLAGS_NODEALLOC
Content-Language: en-US
To:     Zhang Boyang <zhangboyang.id@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220806114943.8754-1-zhangboyang.id@gmail.com>
 <20220806114943.8754-2-zhangboyang.id@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220806114943.8754-2-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/22 5:49 AM, Zhang Boyang wrote:
> Previously, for file-backed loop devices, REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES (without REQ_NOUNMAP) are implemented using
> fallocate(FALLOC_FL_PUNCH_HOLE), which will cause the underlying file to
> be sparse and disk space freed. The users have no choice to prevent this
> this from happening.
> 
> This patch introduces LO_FLAGS_NODEALLOC. With this flag set,
> REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES are forced to use
> fallocate(FALLOC_FL_ZERO_RANGE). The disk space of underlying file is
> kept allocated. This is useful if users, for example, want to use a
> preallocated file as the backing file.

Just in terms of readability, I would prefer if NO_DEALLOC is used
consistently rather than NODEALLOC. The latter reads more like
node-alloc to me.

-- 
Jens Axboe

