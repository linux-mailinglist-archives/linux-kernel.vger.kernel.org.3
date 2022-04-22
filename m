Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B050BA01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448610AbiDVOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448593AbiDVOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:25:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5435A16E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:22:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a10so9182093oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Dm1Q3RuZS/84y7al/vWL+CiE8BS1ax90BXjLHlS5WHg=;
        b=tc5skVD9Ooc0/MV4kUSZ6U6QULZlxjw5oYMH+oPpJQay3KTBdL6Xy91ms4LgRhOCVq
         ZL948bjr1EozQ2OHYug9UDfA1eyV+ZkcLsHJq54pVHR//PzGmgBe9nnsrow4js5QoTRC
         rQ+98GrAIu9uUZQzt1sUAetrdBFnl/mnyN+aFdW1bqsxhcbL1IW/aWHNEDdf0S30KWHc
         aAeKJBHyfPwlt2ozzcD02HNqqo95HCWo/uRyXkQdPOyDGrnQ8iMgKoNKrAbAm5AbThFn
         8HedfImyBSnGfATVz2g+xECKUJirpmU1Jy9iPgDtk7Tijoy+MN9VlH8paVZrDQxE5LqC
         vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Dm1Q3RuZS/84y7al/vWL+CiE8BS1ax90BXjLHlS5WHg=;
        b=sG24titIVVt7LPJM9JvpzIC3Je8w/auAlVeiMlOgcNJDTni4jLBq2DyMB03DGA7SpP
         oTfXvZ1xdNZWI9cltfseREp7aWVF2rVXnfwGVeWbE/+5V+QGNKrRKPwqDh9fEFhCQYW8
         g2b+uk4EhEKfHQEezfx/xpH/2N+wK6uoo7HT64x2TCcpHYjnk73KKTUaV+0Klz7+AQhh
         fH8NPJfDmlzMB8ackPezvuapRSL62kVs0589HgMPCkuIGI74m2TTIdAyfa+pUlHbOnyB
         H4qkcNklBY4roDzDB1znbOtoqdM6wNAIygrGOjSrKgf/UE/qgKkwjxuuHxklehro8t8+
         pAjg==
X-Gm-Message-State: AOAM5326CmCof3S8fju31O7pUb97Ss1x8o63sljcuunAmveayY9SoHcM
        X5NGG9JhZDwzwTyyYOxLUQ4s3illldUZ8Q==
X-Google-Smtp-Source: ABdhPJyWXPHobhLmtwoHxIUDVM8nl4YALwg9uoBKl2RI+Bw26vjUChcDENNVqy8VRrFcuG1GXFA5bQ==
X-Received: by 2002:a05:6808:124f:b0:321:855d:5b19 with SMTP id o15-20020a056808124f00b00321855d5b19mr2465775oiv.30.1650637355858;
        Fri, 22 Apr 2022 07:22:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm822098oos.22.2022.04.22.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:22:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id AEDAD1FFB7;
        Fri, 22 Apr 2022 15:22:32 +0100 (BST)
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
User-agent: mu4e 1.7.13; emacs 28.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alex =?utf-8?Q?Ben?= =?utf-8?Q?n=C3=A9e?= 
        <alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date:   Fri, 22 Apr 2022 15:21:10 +0100
In-reply-to: <20220405093759.1126835-1-alex.bennee@linaro.org>
Message-ID: <87wnfhtcyf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is another attempt to come up with an RPMB API for the kernel.
> The last discussion of this was in the thread:

Ping?

Any other comments or reviews? Is there a desire to make other devices
that provide RPMB functionality visible via a common API?

>
>   Subject: [RFC PATCH  0/5] RPMB internal and user-space API + WIP virtio=
-rpmb frontend
>   Date: Wed,  3 Mar 2021 13:54:55 +0000
>   Message-Id: <20210303135500.24673-1-alex.bennee@linaro.org>
>
> The series provides for the RPMB sub-system, a new chardev API driven
> by ioctls and a full multi-block capable virtio-rpmb driver. You can
> find a working vhost-user backend in my QEMU branch here:
>
>   https://github.com/stsquad/qemu/commits/virtio/vhost-user-rpmb-v2
>
> The branch is a little messy but I'll be posting a cleaned up version
> in the following weeks. The only real changes to the backend is the
> multi-block awareness and some tweaks to deal with QEMU internals
> handling VirtIO config space messages which weren't previously
> exercised. The test.sh script in tools/rpmb works through the various
> transactions but isn't comprehensive.
>
> Changes since the last posting:
>
>   - frame construction is mostly back in userspace
>
>   The previous discussion showed there wasn't any appetite for using
>   the kernels keyctl() interface so userspace yet again takes
>   responsibility for constructing most* frames. Currently these are
>   all pure virtio-rpmb frames but the code is written so we can plug
>   in additional frame types. The virtio-rpmb driver does some
>   validation and in some cases (* read-blocks) constructs the request
>   frame in the driver. It would take someone implementing a driver for
>   another RPMB device type to see if this makes sense.
>
>   - user-space interface is still split across several ioctls
>
>   Although 3 of the ioctls share the common rpmb_ioc_reqresp_cmd
>   structure it does mean things like capacity, write_count and
>   read_blocks can have their own structure associated with the
>   command.
>
> As before I shall follow up with the QEMU based vhost-user backend and
> hopefully a rust-vmm re-implementation. However I've no direct
> interest in implementing the interfaces to real hardware. I leave that
> to people who have access to such things and are willing to take up
> the maintainer burden if this is merged.
>
> Regards,
>
> Alex
>=20=20=20=20=20
>
> Alex Benn=C3=A9e (4):
>   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>   char: rpmb: provide a user space interface
>   rpmb: create virtio rpmb frontend driver
>   tools rpmb: add RPBM access tool
>
>  .../userspace-api/ioctl/ioctl-number.rst      |    1 +
>  MAINTAINERS                                   |    9 +
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    1 +
>  drivers/rpmb/Kconfig                          |   28 +
>  drivers/rpmb/Makefile                         |    9 +
>  drivers/rpmb/cdev.c                           |  309 +++++
>  drivers/rpmb/core.c                           |  439 +++++++
>  drivers/rpmb/rpmb-cdev.h                      |   17 +
>  drivers/rpmb/virtio_rpmb.c                    |  518 ++++++++
>  include/linux/rpmb.h                          |  182 +++
>  include/uapi/linux/rpmb.h                     |   99 ++
>  include/uapi/linux/virtio_rpmb.h              |   54 +
>  tools/Makefile                                |   16 +-
>  tools/rpmb/.gitignore                         |    2 +
>  tools/rpmb/Makefile                           |   41 +
>  tools/rpmb/key                                |    1 +
>  tools/rpmb/rpmb.c                             | 1083 +++++++++++++++++
>  tools/rpmb/test.sh                            |   22 +
>  19 files changed, 2828 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/rpmb/Kconfig
>  create mode 100644 drivers/rpmb/Makefile
>  create mode 100644 drivers/rpmb/cdev.c
>  create mode 100644 drivers/rpmb/core.c
>  create mode 100644 drivers/rpmb/rpmb-cdev.h
>  create mode 100644 drivers/rpmb/virtio_rpmb.c
>  create mode 100644 include/linux/rpmb.h
>  create mode 100644 include/uapi/linux/rpmb.h
>  create mode 100644 include/uapi/linux/virtio_rpmb.h
>  create mode 100644 tools/rpmb/.gitignore
>  create mode 100644 tools/rpmb/Makefile
>  create mode 100644 tools/rpmb/key
>  create mode 100644 tools/rpmb/rpmb.c
>  create mode 100755 tools/rpmb/test.sh


--=20
Alex Benn=C3=A9e
