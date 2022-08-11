Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8065B59082A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiHKVgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHKVgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7A119F0DB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660253797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WZaycEP+nZLu18YDIzSaBPrfwBpX8nQzmEAF9yLISJU=;
        b=dR5dYTymewF7FWbjAIZWagOlwaeK6AKBTDu65tDsQMNQPnr8RoN+j0BEhCazppFxX2eeWG
        20cemhkIdy7JoqazT/4z9x671v6A47pGAgypmMhB7xaw8dx83wnOlhdFdRjcMd8Q+6K1tB
        mIhspXk+5G4B14qH6hVE5uvQM3iuSZU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-OO4sD_VXNn6kwmTeK87p4w-1; Thu, 11 Aug 2022 17:36:36 -0400
X-MC-Unique: OO4sD_VXNn6kwmTeK87p4w-1
Received: by mail-io1-f69.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso10354601ioe.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=WZaycEP+nZLu18YDIzSaBPrfwBpX8nQzmEAF9yLISJU=;
        b=HALjQoiPhmLEs/VySRPr8+1cplzG7NQGNfRgTVeBVBDUYcO1dXZ83IxFg/VRbFQaZt
         cA9piaxWogjzkK5eN/S26Br+VbPcgKGBDxYC1dmVgECpSDZLr84WHX0moFQZn92YI/k/
         5PdUTj96eh4Iw6Zz39oYcoTuY1ZO6fWbAKu9ja0O0cdav2f+PqLVJicGhSQG0qc20j23
         Ob6n1gDye5OtLghhHOoqfpcGWeDeTDlieCiyy0o7dYdYIlF3nCFzxf/PYjh2dS3IfJjp
         n+SVF2NbzM+W7LuvUImh/ZNbf/V0/M2IWNVerTKvsm58dwjo9YNEAsIX7LB3Ao2DzW/Y
         t7AA==
X-Gm-Message-State: ACgBeo26bmhHk0wr+2gDFzuY1i4/p7Hgsrt/97j+oGvmyRiGRFXMWRHV
        ssEvnuGAecMkr5/ii5Z6NpVQLG+FzSv2ZTqttqtXborb28uQmBHnR0lzu6wAKOSAGRQtWgfV877
        Hcd5yzAd2fqmZAUqAYDBoX6g5
X-Received: by 2002:a05:6638:e82:b0:343:4d92:616f with SMTP id p2-20020a0566380e8200b003434d92616fmr595764jas.166.1660253795906;
        Thu, 11 Aug 2022 14:36:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR50tuCMR24UpJfhk188DB8Xdy34VDTNqzsXG7dfF/SZhinsloUn7kB/WWc1sWNK8jFGJUw8qQ==
X-Received: by 2002:a05:6638:e82:b0:343:4d92:616f with SMTP id p2-20020a0566380e8200b003434d92616fmr595748jas.166.1660253795155;
        Thu, 11 Aug 2022 14:36:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y7-20020a029507000000b00342a1021507sm245720jah.123.2022.08.11.14.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:36:34 -0700 (PDT)
Date:   Thu, 11 Aug 2022 15:36:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [GIT PULL] VFIO updates for v6.0-rc1 (part 2)
Message-ID: <20220811153632.0ce73f72.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've had a request to get this into the current merge window to ease
re-bases in the next development cycle.  Thanks,

Alex

The following changes since commit c8a684e2e110376c58f0bfa30fb3855d1e319670:

  Merge tag 'leds-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds (2022-08-08 11:36:21 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.0-rc1pt2

for you to fetch changes up to 0f3e72b5c8cfa0b57dc4fc7703a0a42dbc200ba9:

  vfio: Move vfio.c to vfio_main.c (2022-08-08 14:33:41 -0600)

----------------------------------------------------------------
VFIO updates for v6.0-rc1 (part 2)

 - Rename vfio source file to more easily allow additional source
   files in the upcoming development cycles (Jason Gunthorpe)

----------------------------------------------------------------
Jason Gunthorpe (1):
      vfio: Move vfio.c to vfio_main.c

 drivers/vfio/Makefile                | 2 ++
 drivers/vfio/{vfio.c => vfio_main.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/vfio/{vfio.c => vfio_main.c} (100%)

