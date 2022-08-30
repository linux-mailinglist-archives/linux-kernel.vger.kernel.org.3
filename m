Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6245A6ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiH3VEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiH3VEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:04:52 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA827AE5E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:04:50 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11c4d7d4683so19762979fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=vhplHiofN1IwDs+sPIAVXi1uUH/q8bkxHPA+4MeuY6w=;
        b=rx6STPbUMXOjJIkpPmYFzYBv/zqYhXUEdfrB6LuyHYoBbf3T/Gr0ZH5BgFZbl4C6zu
         sa8QVfciMeSp2ItILMkdzkPoz3hkE3CMX80Tbu0oF/AkiX1l48AjQvvfu97kbqKC1EP8
         B7F5edsosTU4gu5LnQGSlCii3iSTehQr1VRgJS4jCUqXHyA4ZVtLRw60chbW2YYoXwL7
         8vq1vmSHND8w+RyUQU2Icxoc+lTCcuNZBoJUQGqZUy+cryNcEqpiHejBdo58t71eNR1X
         6xONRKOcU2KgR67IVjHqgCdwMOcF4VCM8ZgqUxNgivmULN5QO9Y92Nf/7i+ux0xK/eNI
         YlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vhplHiofN1IwDs+sPIAVXi1uUH/q8bkxHPA+4MeuY6w=;
        b=BnClArBMIExcs+Tzi+/DoWibaz2OJvxXtk8dAyVcgUKJu1W2kvnHeRvVuQtm/ex+/z
         iy7n8N908E6R/8dhfatb3s4QlxF0FGwY1pVv9/15Sqyqfbm5iLnYkcVpQRZVuhMYS6tN
         t6ubkQJDFSYTUk5O87gQ23qrjyS9hnx0iuD31UzXxLb6Z6gsAM2SAadYrFrsB6mWerVT
         A6Gp+R3lrOIUiBtdeS0MMykM9qUufNL8lgzlEsThHw0vC2q11Y+Bg6excuCReGZguMCF
         tmvk8MDW4rPjpMgc7mGwdfRGe8QYF2AiXtn+b92FoMdElTu9siYzOws6FGTdY0/shjOG
         bC0A==
X-Gm-Message-State: ACgBeo1MHEDUqkYMkB3BdoJKjRZpzaAwJZh4UTjOwdUYNM3UrvYjG1gA
        Cd5iW1kF4jX2omrCn65C0FZxVSCTjfZzUWBKgzD7
X-Google-Smtp-Source: AA6agR6CdgbXULQ7dGtNu5GDf9fktFU8ysMzqSs4r3qAn4FCoK9GqEenVLzT8tm2ugfY1EenJehJS1YSnVi9Z/NQ6bI=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr44936oie.41.1661893489715; Tue, 30 Aug
 2022 14:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220830154500.18165-1-cgzones@googlemail.com>
In-Reply-To: <20220830154500.18165-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 17:04:38 -0400
Message-ID: <CAHC9VhTe92h-FR0GOepVrPqWwOgKLPV6NcXxi4sRpAjEbPkt5w@mail.gmail.com>
Subject: Re: [PATCH] selinux: use int arrays for boolean values
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:45 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not cast pointers of signed integers to pointers of unsigned integers
> and vice versa.
>
> It should currently not be an issue since they hold SELinux boolean
> values which should only contain either 0's or 1's, which should have
> the same representation.
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1485:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1485:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1485:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1402:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1402:48:    expected int *values
>     security/selinux/selinuxfs.c:1402:48:    got unsigned int *bool_pendi=
ng_values
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> Previous patch proposal: https://patchwork.kernel.org/project/selinux/pat=
ch/20220502135907.31035-1-cgzones@googlemail.com/
> ---
>  security/selinux/selinuxfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
