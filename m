Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351F4F4E58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588965AbiDFAR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573283AbiDESoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:44:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658464665D;
        Tue,  5 Apr 2022 11:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11B8EB81B96;
        Tue,  5 Apr 2022 18:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FFC385A1;
        Tue,  5 Apr 2022 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184150;
        bh=mvmeqellZ7AaVX6VtMeym2zkFjPuHDmY40DOFQO7lfM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tR+IxCxWCoiQvHe8Cgma6S5S8B7nJicGKA4dX+azos97LSyLku3xwIs/QMDK0IQG5
         wy6/34DtwvSWrmRbHhOhDcUG/Oth/4/TAXwgk/qNlMAY8TkBdZNKerNGWawMtksxTm
         6r81YvWOVEjI+4r8VU6bXplBN3cM+cV33LRowXoDxXryUKcfin1bad40+x7LSHrtEr
         rmuNGZCwCCcCbUeYfEQK0l52KOondHsj8goVnoc8/6WtRiIX3pCgUgSkksaR05XUYq
         BSBvqT3npvApJymP6iMxePAUTbevbEQYBCWioPkq1umK5OONCYsLmk07tHpwevxMmA
         LOUiT4yqKZULQ==
Message-ID: <539fa318941debfe757874c4fb067f6018777045.camel@kernel.org>
Subject: Re: [PATCH V3 21/30] selftests/sgx: Add test for EPCM permission
 changes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Apr 2022 21:43:40 +0300
In-Reply-To: <5ea8d567-5d82-6815-013a-70f4e3f913b9@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
         <b2304ac0322d945b4bfdce36d3aae654f6ed35a0.1648847675.git.reinette.chatre@intel.com>
         <Ykvpi6HRL9cLorw6@kernel.org>
         <5ea8d567-5d82-6815-013a-70f4e3f913b9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-05 at 10:28 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/5/2022 12:02 AM, Jarkko Sakkinen wrote:
> > Lacking:
> >=20
> > KERNEL SELFTEST FRAMEWORK
> > M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Shuah Khan <shuah@kernel.org>
> > M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Shuah Khan <skhan@linuxfoundation=
.org>
> > L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-kselftest@vger.kernel.org
> > S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > Q:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://patchwork.kernel.org/proj=
ect/linux-kselftest/list/
> > T:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git git://git.kernel.org/pub/scm/=
linux/kernel/git/shuah/linux-kselftest.git
> > F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/dev-tools/kselftest=
*
> > F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tools/testing/selftests/
> >=20
>=20
> My apologies. I'll add the kselftest folks to the next version.
>=20
> Reinette

No worries, just reminding that now is a good time, since the different
parts of the patch set are settling.=20

BR, Jarkko

