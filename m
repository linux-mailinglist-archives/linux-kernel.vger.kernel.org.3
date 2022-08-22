Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10A759B8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiHVFIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiHVFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:08:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38605BF5E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661144856;
        bh=8z4lpXFA7CWoZV7YqGU3fXduZtGbeS2RhvwMnudjN0s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ISEQus0s0uO5KUKQUWmJ1A/9Y/mUkUK72jCJg4a3S7W/gniLQ03EmyhM4oS84MFOS
         ZE+upJuGN+J3K7oe7MsX/5MSGYGqw4Ro4374PYgC72aUKXLB96dVCYQmD+YzTbMdDA
         O9vPGnd4GFy/8MxoSVWcyV4BiwKwxUtKrvseMILY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.199]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1ocPrX2ICJ-00E2oY; Mon, 22
 Aug 2022 07:07:36 +0200
Message-ID: <0cdf42e6ee7d97033020d7a09b74cec23cde03a6.camel@gmx.de>
Subject: Re: regression bisect  --> 88f1669019bd " scsi: sd: Rework
 asynchronous resume support"
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com
Date:   Mon, 22 Aug 2022 07:07:35 +0200
In-Reply-To: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
References: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHxca0k0KfZCfO7VH2IVOvLwSlh16iAsBkCMxjR65/5rxakX8Yi
 XtGR0xR/DSLlScndJGcsNfxSpWQvIt3OiJzHI7prfhGX7oXcFjK+96qPYyAbD9UTBENZeDm
 /kXPw4fRobik/tO49pryVT0hd4PmNSpoD/nCaDws3O2qYXyrQKDAOV3SV/+IJUf6e23PDCk
 sFIo7v1cXZMBo8A66D+VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7hL50PyyYI=:74IMV9yq8mzTreB4PMNasb
 SLySAgFuD8tav16vDlXJDCQp4MBuOHaUd4HlQXVtjIDj6cjOya19wW5/cfkFzM4UIwnQtgPwr
 K07Vriqd/VB71tNKlIQ2p7tljmvzZQ9NM18zTR5xK+gEv8TCiQd2JJ9EcAnzuEE09aULPLDHK
 HW2cljKEcNqVs4buAWKJTO++WLslzilF5uzYyuqXi7YXlgzeyJv/KYi78f3ljQE87VygqoN1h
 LIF5kX56I9dSR1D+A75X4jCuBg38pOpyYpifJajrNI04uCXqQdqOP/12UrdUNHb/XmqYE7xRp
 l7KrLRqx0jwchLY8dMi6H6Wu/9HrMu6j5zeSKiS7Qz8UeKrlKSfGkyH/8LCVqkLgbjSrF8Y80
 hFZ96h72rbzvFSOuteQL3XapueTI1zjeQuj/onK+Je7amLC/zwuIxlDCxZW90eKUoQXiIczrI
 yJNQFHJK2JKm1U0H1I8R9H6vX1IMtyXuiqmeIiUGTEeJwtGPhVTYkuZDkqC8RYIiIKcBazUFv
 XTyR2FSUvawyNcGYTtUM1c71GW5JSyf53m9+NuigCBszNDUbaUhtaJqEM8lCw1EpGmKI3aBJh
 E1CufRKus+fRk7g4pR0Xv8c/7a7Eg2a4IqIsvCrHvol/oE9BEtY+BUmnpLdJ95DmjS8MsYukE
 pggbbT6wwhNnFnNRXZNB2m0F9yz7dzdSVjBfHkCmdUz79X7S27gj3fEFeCxmUS8MDCzS7/7p5
 6DJG2r6UUK8mOKbSFkfWtUauHhlEdOcB+hl9eyKBroY/JH8c1gXY2ldJTgxNg13Gl8QHRuxu7
 FVms/OtI8vunaCF8vHyt22yRyPOT1B17Ok099ww6brIU11LgM4SckWCmwpWlsmBZS5uQgwFCg
 iuHS4znxMFlDoAt+x6O9HhsDMSS2UbZBLY53HaW2EQSomjY3bAtGmjcY+dnaGkLmNEkpBujLw
 iLPBXMESxxkIF/sUv1MZ4AiPaJTb2SMefD6RhLSY2sSTX0/YpsCg780BZ3eqiCQ2Ma1SMVdIe
 biJy84hHLcuf+jCHQiFvSt00yDobD17tOLC0yfB0pAhXzpeDpv/vijgFDfDwI5hJKup92RPlP
 +aojzy9L1RqnCtwvThg4hzgMTMTwetkB5Gn+rntal1MBYLduUG1OwXgRA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-21 at 09:34 +0200, Mike Galbraith wrote:
> Greetings,
>
> My box claims this patch is a dud for it, symptom being hang during
> suspend _after_ a successful suspend/resume cycle. Revert at bisect
> starting point and now HEAD (15b3f48a4339) confirms box's assertion.

Should have tried lappy yesterday too, but had to run.. 2nd suspend
hang is repeatable there too, as is revert curing it.

	-Mike
