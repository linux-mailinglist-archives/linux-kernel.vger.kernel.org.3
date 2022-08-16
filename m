Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15285964DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiHPVpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiHPVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:45:43 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1567478
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:42 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-32194238c77so186233337b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E+UpqcFwgELt9+6MJIAJVd5JzMPdNiyIwaSeI8WmY6M=;
        b=Mt2RG2AE03PBhIhHfekRlsuDB0YqsgZhUuqVmdXQAKDRDmSL4bq8wec47PSx5Fjvjg
         GEodI/dqr8I7fvbcCyGjMakpznZofiAXvPB57TvLyxO1gCn2o+TerGc6xtNjkPGHNpnJ
         Dg31DNDB88B2xrcbcNouv9JcU/t8h0Q/zATNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E+UpqcFwgELt9+6MJIAJVd5JzMPdNiyIwaSeI8WmY6M=;
        b=wNC3k9OZ1slpdagR3p2e2dkFv/elF8Tsi23j+ti7uHdq/qFwdvu3elxM1dlgz9FOkm
         nV+epYKoCdiFMClQ+Q2aSLjnC0PMp+yVwbgu4a/XItCf+VFc/k5cvUI3CwpcducxpqJa
         UTA7IUXz6TKP0pVSBWasW6NHYnJTR6JQRqSzxN2F3k6t6Zanl+AMNP/bCJqSkAwQSPzT
         CDQvIrRk9eMdTrdEJXhXbswR8pQe3alsOXteE/hQFm6f2eZbyf30Aecw17QMPDqhxGKo
         mpri3os93KM3KvatPDw8oK/HireAKvQ5PG1RNwhkxCC12CCLiBKNTpIpHKFXKeHM2bqM
         LdZQ==
X-Gm-Message-State: ACgBeo2faSMWvdeaNSlBJbxcGCzdNRL/FCCx8kr3Adt/TxiFJSw6/G3K
        zQqPCzpJBHG1wje3IwohmYIMf9ZptmPtbCNqYiNTlg==
X-Google-Smtp-Source: AA6agR6xkEO0vUoHT/2LMaG3iIZe2zaePbLtIrzuzhHhZJXzy89lBKkDy6ybOVhCy/748r/hMEfqnzDn4hYVm26PV/g=
X-Received: by 2002:a81:84cf:0:b0:324:d62c:aee with SMTP id
 u198-20020a8184cf000000b00324d62c0aeemr18697266ywf.489.1660686342014; Tue, 16
 Aug 2022 14:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-6-pmalani@chromium.org> <YvsnRXLVbcI+McEo@google.com>
In-Reply-To: <YvsnRXLVbcI+McEo@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 16 Aug 2022 14:45:31 -0700
Message-ID: <CACeCKaemEZV4BZetUQmsWF-SAArQDkzmtszD6jDxsvhqLAxLPA@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] platform/chrome: cros_typec_switch: Register mode switches
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:12 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:34:26AM +0000, Prashant Malani wrote:
> > Register mode switch devices for Type C connectors, when they are
> > specified by firmware. These control Type C configuration for any USB
> > Type-C mode switches (sometimes known as "muxes") which are controlled
> > by the Chrome EC.
>
> To be consistent to the commit message, s/Type C/Type-C/g.
>
> To be consistent to the series, I guess you would like to use ChromeOS
> instead of Chrome?

Done.

>
> > @@ -235,6 +264,17 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
> >               }
> >
> >               dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
> > +
> > +             if (!fwnode_property_read_bool(fwnode, "mode-switch"))
> > +                     continue;
>
> Would it be better to use device_property_present()?

Fixed in v6.
