Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC954C60B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiFOK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbiFOK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:28:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE3101FE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso1614231pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znEIzE4EgTWOiFZf5Cm3kxNmUH6IPbVNQv1UUuyV/Hc=;
        b=qV9h/UpNmydq91H3mP6CVU6NclHsJYkwfhKtoANC/6Tu2zBT/yPUPmiRQaF/d90inO
         tLv2mruFsa6BwzQwqBzSb2nHAcMM6DnbKRwhwxKDO7XOk7s6jDF5FQCSFAz3pJTuJYEl
         p2TF12/VNwu5xzgYtkfUEeoSclxn2LgsBLG7z+Rp6npZcXpPOUXF9pjLz4NSabazZOe+
         2wDQv+4nzLsoXymU0D+hO3piw8G3YSlQbtdeFRfSvTR/V4Hady+iSnrLrgyJxXL4sPPD
         T+9JSIndQ/pgJqevcyDY0DpGxLlZyJNy2NOiPEZ151KZXZSntI6fZMjO2fYbx554bdOz
         iwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znEIzE4EgTWOiFZf5Cm3kxNmUH6IPbVNQv1UUuyV/Hc=;
        b=dMtDpMYrAPf7p3inR1vO8rRqcBSPpA0EsVmhurkbcxRiZV7UR1tG0ajSdGub1JLLex
         Hdyd+zQeOzbndlai4WDbi2aPFog0ef8g5m7ZpZ/rWhog0afgAPZ3C0OXv0H3MuVr8MPf
         sjlvJJUqpcWNazwDumn5iBSdFHeSsU6z5rX9eH1f88al0MGQqIBhC7QjbYMFRPaQmAzA
         IM37dC6+ebxvov6aGBtyEsninEvn6KagPbtNpNLZzptrbHUFjuYIVUUAulrLAfe59ksK
         miD8vs5G8b2dz8b4AxblNNJN2/HAUS8FzuVw3ZNoUtsqfdbIMlvQbRWUYpNSfVz/8ip3
         vbuA==
X-Gm-Message-State: AJIora8PPXs2InI16a9uS7VSpVTmVS/s25tjJ/wMvOsKzRQizK67KBlO
        lyJuJ1rnfNOMJHaCQiGZK+I=
X-Google-Smtp-Source: AGRyM1uylrZN/TnBR+RkyEvlG9LSFkRtn1a0pXgqvgeKkHmp20cQHxemz9ZiU5FVzwHH9jENOzszIw==
X-Received: by 2002:a17:903:41c6:b0:164:1050:49ac with SMTP id u6-20020a17090341c600b00164105049acmr8762042ple.138.1655288881189;
        Wed, 15 Jun 2022 03:28:01 -0700 (PDT)
Received: from localhost ([122.183.153.161])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78182000000b0051bf246ca2bsm9407279pfi.100.2022.06.15.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:28:00 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:27:57 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "R, Monish Kumar" <monish.kumar.r@intel.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <20220615102757.ugvs6vdxf66nrmyn@quentin>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
 <20220613135549.GA1714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613135549.GA1714@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
On Mon, Jun 13, 2022 at 03:55:49PM +0200, Christoph Hellwig wrote:
> It all appears as PCIe, but the pci_dev has an is_thunderbolt flag.
> 
> Thanks to both of you for the information.  I'd like to wait until the
> end of the week or so if we can hear something from Samsung, and if we
> don't we'll have to quirk based on the model number.
Our FW team has started looking into the issue. They said they will try
to come up with a solution before 5.20. If not, we can add this quirk
based on the FW ver. and a proper solution can be added by 5.21.
> 
