Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75460597821
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbiHQUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiHQUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:39:54 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58319BB71;
        Wed, 17 Aug 2022 13:39:53 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id c3so14309433vsc.6;
        Wed, 17 Aug 2022 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pby1yMSBPXIRmnbK0mp8JoI7OWrC1joW57AiQcbBP0Q=;
        b=inC+UgcY0EIaKzbjmu9TomN+u6btHsSO05ufbPi8fwp81bBlk7mkWQVr7pqZ9RRqLU
         hvBJbrD1nAXbb0hc5VwXN8Zy0wnZm1nu/acyUVP51b3R3tpQPCOkPmzPFeHbyBLmJyeD
         uUsXNzjU/sI4QGzkncRbj0amd+xLIyLUVu96aUe4zdN5DyQq8bScni4Xe6fhYbd8MlXQ
         fldeeRjYOZMaUDbfhU72Iu9YETXX3PT74/PjlHmCWhL1iSDhIi5IpALmZhk32MpKs2FF
         E8mXcJQcYSqqpqHwX1R1NrAsGeifiFjZgcxsHNJrwzwd55cY55RnJW8VJH40ZxVikK/Z
         43hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pby1yMSBPXIRmnbK0mp8JoI7OWrC1joW57AiQcbBP0Q=;
        b=xUDgOTbcmGPKYzywZoFSJE+5mEMQBgLL1LHD3hF6vZ1sZIiRlKV/xKYoG8+V2BurVH
         lyMt9BdGzN3/+Cxe8ZJmqhEJ7XNyPyzsQmZzvCSBoDidb6u9jtA27YVZAQ2+f3urfZCc
         nz+digFju9/S/m3ad79dgxGsOVnurAYL6RHPxs3c21KCjKPOwryxPSKvnQUDToe5vC4G
         OAscDI8GaTypDJYmWP8T74uq27xyGAmkD5Vo+DiRjRrU4LK3zIPhBc/U3kJe6nNPgvhZ
         c0gn4UsiDH09mB6gRindeN4f1N30AK5Bxi/NDG0BSP8oRAwZGvNsW4HSKFa7iXwXeQTx
         BZtw==
X-Gm-Message-State: ACgBeo1gEoH68FQaC+X2avqg+ge9teDYUvnNC8Kbqtkebb5S9Mcn5jDE
        +GHCYvHixb6A4GWYq6qY7sD940NMAkAAozcLls0=
X-Google-Smtp-Source: AA6agR7TXYadG2mmWjKCH/W19SWAIUnwsaui5VCW1HOoHb7uysbbyVqhETXpaRT38pEdo0NpybxBnNWQxdaC+V4gaI0=
X-Received: by 2002:a67:be01:0:b0:388:7361:2eb3 with SMTP id
 x1-20020a67be01000000b0038873612eb3mr11215542vsq.14.1660768792854; Wed, 17
 Aug 2022 13:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <YvU4GD8HtZ1A4dhI@debian> <20220812090731.31da7d85@oak.ozlabs.ibm.com>
 <20220817094309.140c346e@canb.auug.org.au>
In-Reply-To: <20220817094309.140c346e@canb.auug.org.au>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 17 Aug 2022 21:39:17 +0100
Message-ID: <CADVatmO-kc93dQc9TPy7ZjGuLUUut7or1VLGYkLWTw803mkWiQ@mail.gmail.com>
Subject: Re: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:43 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Fri, 12 Aug 2022 09:07:31 +1000 Stephen Rothwell <sfr@rothwell.id.au> wrote:
> >
> > On Thu, 11 Aug 2022 18:10:48 +0100 "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Not sure if it has been reported, builds of riscv, alpha, s390, arm,
> > > arm64, xtensa, mips, csky allmodconfig have failed to build next-20220811
> > > with the error:
> > >
> > > ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> > > ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> > >
> > > git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC pass-through during mode validation")
> > > And, reverting that commit has fixed the build failure.
> > >
> > > I will be happy to test any patch or provide any extra log if needed.
> >
> > I have reverted that commit in today's linux-next.
>
> I have removed that revert.  Sudip, can you recheck when linux-next is
> released, please?

The build failure is not seen with next-20220817.


-- 
Regards
Sudip
