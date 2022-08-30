Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB35A6926
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH3RDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiH3RCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:02:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F085564DC;
        Tue, 30 Aug 2022 10:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1270DB81CE7;
        Tue, 30 Aug 2022 17:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40CBC433B5;
        Tue, 30 Aug 2022 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661878935;
        bh=zuE5tGcx5l76KiYALJlcPI3yxgrWlUht/PYPUm0d3Pc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rMMt+yf0YcS4YEGrBZB3F8AKE8BCcZVzmWFFz5+lOWh5M6+cnzxTA/5Ilr29ggpTd
         LTm988Wa1stViNGxb3TSbRxMaU52eIyctqWYLZMWqtWNugkSZ+eCqdjwCkbbYYnUC3
         FNym7noYDd09zQb/M0pWXTnT1+JCbkTWwgPkxWkcZEcOoeoEv5qMNvLu/adXRKJMFZ
         2wefNSf3OAKwz1WBKSYA0MecFVgpkes/qc2riKV40RTnuaF4q4BaKXAJWjEwunPw8+
         g16VRLATLmKPNQDaoAxu+JtNKgVC0Jt3ia4/ubETBpdjZCAz3dAe8W6/dMBVMBYLQ/
         3ekIe/uXwGWTA==
Received: by mail-ot1-f48.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so441189oth.8;
        Tue, 30 Aug 2022 10:02:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo2HqwhdyRBfB55CvNjdmqo94KnlBrB/8wlXCf3NFOhEyl/Qcsei
        PSzkhgCUSJLbii0hVTSi+KbEt37Pi3EUhrl0A1E=
X-Google-Smtp-Source: AA6agR6f59zdB8lJJrFAGXPCZn/Rpe0ho5wIpCSfjqQnPjR+27z8ENLOP8XFp8/Lw2qT/IwjRESPQOWObdDrjOI8nmU=
X-Received: by 2002:a05:6830:b85:b0:605:4e76:f077 with SMTP id
 a5-20020a0568300b8500b006054e76f077mr8547324otv.211.1661878934868; Tue, 30
 Aug 2022 10:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com> <20220830084925.5608-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220830084925.5608-2-ilpo.jarvinen@linux.intel.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Tue, 30 Aug 2022 12:01:37 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXDaqG5uR-A3gC4qrFBwtbm7ZwFp0oXwUYGVDU=Ru-gPQ@mail.gmail.com>
Message-ID: <CAOZdJXXDaqG5uR-A3gC4qrFBwtbm7ZwFp0oXwUYGVDU=Ru-gPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] serial: ucc_uart: Remove custom frame size calculation
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Timur Tabi <timur@kernel.org>,
        PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 3:49 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> The number of bits can be calculated using tty_get_frame_size(), no
> need for the driver to do it on its own.
>
> Also remove a comment on number of bits that doesn't match the code nor
> the comment on ucc_uart_pram's rx_length ("minus 1" part differs). That
> comment seems a verbatim copy of that in cpm_uart/cpm_uart_core.c
> anyway so perhaps it was just copied over w/o much thinking.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Timur Tabi <timur@kernel.org>
