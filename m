Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E15ACCF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiIEH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiIEH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:27:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B82BFC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:26:42 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93A183F0ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662362800;
        bh=ThEpzsYAWPQ+vR3sDdfrBp9HRNSWWVxORABQ85lL8jw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eV2uhXLOpxGUULj2Yzz2jNEPRsyQDdGr0JVp5uqPT73FTVH3krEPGEJLAxzdUfdwe
         isoP00W8KCTLOOosdMiBe3MF2ELrV0EASyKphi4Fdbdo5L8VJuBHqf4ypfIW4CdX4i
         NL3R/d95RshwMz72Q3t15KpmwMkx2USHxlStjSctSpbcctQhW9FJkC1zMVg2syzN9u
         zKolb1miQDxT2n+TW6og2ap+6qpQdYmYdhSu9trwte0KEh4MzGlN57uIGrM/NJVzCE
         xbCq0/1CP3OWjmveZGj9MeqiviJgIVAAlinRa36PSeMd1gGm01FBJ/Fkimc14N0BAP
         V2+QseehD9E+w==
Received: by mail-wr1-f69.google.com with SMTP id d30-20020adfa41e000000b00228c0e80c49so177866wra.21
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ThEpzsYAWPQ+vR3sDdfrBp9HRNSWWVxORABQ85lL8jw=;
        b=q7PNeEJcACoIp4/ZEHfUpK6bvu21vmS49uYJZWootKL6ZdTgoYePYQfzhwl0wEVBdL
         lC6dfqPquyub2UU37nvGsjc7j3kj8YjabNbQtQasz8jhD+F4iAJT+XNG4yTUHq7bJOgc
         BfS8IlaALSoVwquK9k8npXuxwu7pUvWCaBfodNll4QRdQLDhtynv5A7IvdrvfocGSbLM
         Uf7Sr2lsNdzYcc9RAKu60nMAvRgdRO5bdoajt+2HfK2yTjrqxhdxPmnM3FGCFYcP7v3P
         OdFA76jDX1AtC6TcnosGTSFTwQ2OycrJzkkpJMmq6bUU5ezsU/kHMZurDEz8y204eUDT
         byMA==
X-Gm-Message-State: ACgBeo0FEC4PASqK/rl7cI6srNn9SizT1hjRnNQTVl/ug9QwVuD6KGxy
        r+ZSp1+TVB7B7hVleZIpW0rzyJTPoNITvRF4r5v7KMUX/wRJswaY3KzmYA2a4P5MH/SlwXB8NtM
        0r7SnHzJmXGHkTNlfYAebfNs/txIuvR4BsCh+r7X0Et9cjkI/NKbruYtWQg==
X-Received: by 2002:a05:6000:2c5:b0:225:618e:1708 with SMTP id o5-20020a05600002c500b00225618e1708mr24710033wry.510.1662362800176;
        Mon, 05 Sep 2022 00:26:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DNgFlxvyoZfpOOUELTnOafjMuqQXkJ0hW4QhgYWzp8crxxH1IY+naMUchHq1loiOEaiVzWAi+X0elo/b3/Oc=
X-Received: by 2002:a05:6000:2c5:b0:225:618e:1708 with SMTP id
 o5-20020a05600002c500b00225618e1708mr24710018wry.510.1662362799922; Mon, 05
 Sep 2022 00:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com> <YxWgGKIAvsxwSz85@black.fi.intel.com>
In-Reply-To: <YxWgGKIAvsxwSz85@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 5 Sep 2022 15:26:28 +0800
Message-ID: <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Mon, Sep 5, 2022 at 3:06 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> > AMD USB4 can not detect external PCIe devices like external NVMe when
> > it's hotplugged, because card/link are not up:
> >
> > pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101
>
> I think the correct solution is then to block them from runtime
> suspending entirely.

Do you mean disable runtime suspend completely? Or just block runtime
suspend for a period?

>
> > Use `lspci` to resume pciehp bridges can find external devices.
> >
> > A long delay before checking card/link presence doesn't help, either.
> > The only way to make the hotplug work is to enable pciehp interrupt and
> > check card presence after the TB switch is added.
> >
> > Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> > the bridge ID so TBT driver can wake them up to check presence.
>
> Let's not add PCI things into TBT driver unless absolutely necessary.

OK. It's getting harder as different components are intertwined
together on new hardwares...

>
> At least on Intel hardware the PCIe hotplug is signaled by SCI when the
> root port is in D3, I wonder if AMD has something similar.

Yes those root ports are resumed to D0 when something is plugged. They
however fail to detect any externel PCIe devices.

Kai-Heng
