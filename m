Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94684576C48
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiGPGzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:55:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54FBBE09
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:55:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f11so4889120plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=QcujZ7/D1KsTI17Sw27DTLcG4qMtDSMf78KGi2YKWO8=;
        b=IZVCSq8IZMO8/zDT2NnJU4ss0dfSDZk9yUQsUtG97P7ZPbFbvFXJRaLOXkqWiHectF
         06Ci9Ku/IfLb2RvE+O7rUN3TsjOlcxQpL5yWkhXpL26JzAG4NpnxHQVHDT+gl045t9VL
         x3AqX47jks4RZUVFZi0w2Ksi5/f/USIxVumS7aGsHxlMP+OZ3OjXZvGJJjrFzQHMQR/A
         sMlY6YwLxTsqo9NyOmKOmkr8jpkDGkRqzLMsLYjuTxcKy54ZPPaaBg1dQc2mlswXW6rO
         3g4lfV+AwzZBW8jDVDXhUy7v9yP5KB0mkMNHgIf4ibCVKmZoDlsauAfcpev3ld5cmtm5
         x6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QcujZ7/D1KsTI17Sw27DTLcG4qMtDSMf78KGi2YKWO8=;
        b=bDu4mNFSQC7opogBRiUuv1IcabgHJ+u5Wh4bIGDS6XlAZrU7u4aYVTjDJG7Bm96lNM
         gnGbITTKBuRbZIs1R4xGQVDlHBqoX3kBqPftjw5A7FO+JWONcBQJndY/TGpMLszBwTkf
         Nqr0W31gzAJrhIg8+ctvlsgBfRYbHaqSG+0R5N+aPkROQgXTTWbFA8gJQmnv9L2260b0
         M5tCbPy8hcz7ehLYrORLk7KRA3qn49418d0nmHrICQOhCJKQay0uCViaeyvTKDhev+Gu
         mpjnbATm4ttR66LiHyjYTXwQOtu55RpwomE98HhypTZDe0v6UX1b+D1ABaArSZ12ZPio
         XfhQ==
X-Gm-Message-State: AJIora+iuVWdGMJSSIGDG9ei+j3rghi2K7jUyh1KT7AQSnkxwYiDUWtW
        ofZdIhMo+PPBPZavYY8kPvMTsOCsvQKkCMcY1gSxSWBQZPvGmw==
X-Google-Smtp-Source: AGRyM1umsE+qDT1gj7i24rYh+YxtgzhCA2TMZ6UPUbynMQn847MT6M248zGA7McdxDGXnDkb2vsLqewvfvbmDzxaRVk=
X-Received: by 2002:a17:903:2143:b0:16b:e136:12d2 with SMTP id
 s3-20020a170903214300b0016be13612d2mr16783908ple.5.1657954508041; Fri, 15 Jul
 2022 23:55:08 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Sat, 16 Jul 2022 12:24:56 +0530
Message-ID: <CAFf+5zjhdxHCEj9UgqFLJyGy59wiLAzq0RKS4EtOYbgGtV4kzA@mail.gmail.com>
Subject: New String Search Algorithm (in case someone needs it).
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New String Search Algorithm (in case someone needs it).

/*
 * License: This file has been released under Apache 2.0 license. The
license can be
 *          found here: https://www.apache.org/licenses/LICENSE-2.0.txt
 */


/* I have invented this new string search algorithm. */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#define ALPHABET_SIZE 256
#define ARRAY_SIZE 256

long new_string_search_algorithm(char *text, char *pattern);
static int show_menu_and_get_user_option(void);
static void do_manual_testing(void);
static void run_automated_tests(void);
static long get_random_number(long lower, long upper);
static char *get_input_from_stdin_and_discard_extra_characters(char
*str, long size);

/*
 * long new_string_search_algorithm(char *text, char *pattern):
 *
 * Function new_string_search_algorithm() searches for the pattern string
 * in the text string. If pattern is found in the text, then the starting
 * index of the match (from the text string) is returned.
 * If pattern is not found in the text then -1 is returned.
 */
long new_string_search_algorithm(char *text, char *pattern)
{

    long skip_table[ALPHABET_SIZE];

    long i = 0;
    long j = 0;
    long temp = 0;

    long text_len = (long)(strlen(text));
    long pattern_len = (long)(strlen(pattern));

    long last_index_of_pattern = pattern_len - 1;

    // initialize skip_table
    for (i = 0; i < ALPHABET_SIZE; i++) {
        skip_table[i] = -1;
    }

    // Preprocess pattern and fill the skip_table. An index of the skip_table
    // represents the corresponding letter of the alphabet. So, index '65'
    // represents letter 'A'. The value in the element at index 'i' of the
    // skip_table is the distance of the last occurrence of that
letter (corresponding to index 'i')
    // in the pattern from the last index of the pattern.
    for (i = 0; i <= last_index_of_pattern; i++) {
        skip_table[(long)(pattern[i])] = last_index_of_pattern - i;
    }

    // start searching
    i = 0;
    while (i < text_len) {

        if ((text_len - i) < pattern_len) {
            return -1;
        }

        temp = skip_table[(long)(text[i + last_index_of_pattern])];

        // We are searching from last to first (right to left). If the last
        // character of the pattern doesn't match character at index
        // 'i + last_index_of_pattern' of the text then we check whether the
        // character at index 'i + last_index_of_pattern' of the text occurs
        // in the pattern or not. If not, then we skip forward a part
of the text string
        // (part is equal to the pattern_len). Else, if yes then we skip temp
        // number of characters in the text string if temp is greater than 0.
        if (pattern[last_index_of_pattern] != text[i + last_index_of_pattern]) {

            if (temp == -1) {

                i = i + pattern_len;

            } else if (temp > 0) {

                i = i + temp;

            }

            continue;

        }

        for (j = last_index_of_pattern - 1; j >= 0; j = j - 1) {

            if (pattern[j] != text[i + j]) {

                if (skip_table[(long)(text[i + j])] == -1) {

                    i = i + j;

                }

                break;
            }

        } // end of inner for loop

        if (j == -1) { //string matched
            return i;
        }

        i = i + 1;

    } // end of while loop

    return -1;

} // end of new_string_search_algorithm

int main(void)
{

    int option = 0;

    while (1) {

        option = show_menu_and_get_user_option();

        switch (option) {

            case 1:
                do_manual_testing();
                break;

            case 2:
                run_automated_tests();
                break;

            case 3:
                printf("\n");
                printf("Exiting..\n\n");
                exit(0);

        } // end of switch

    } // end of while (1)

} // end of main

static int show_menu_and_get_user_option(void)
{

    int option = 0;

    do {

        system("clear");

        printf("\n\n");

        printf("---------- Menu ----------\n\n");

        printf("1. Do manual testing.\n");
        printf("2. Run automated tests.\n");
        printf("3. Exit.\n");

        printf("\n");

        printf("Please enter a valid option (1 - 3): ");

        scanf("%d", &option);

        get_input_from_stdin_and_discard_extra_characters(NULL, 0);

    } while ((option < 1) || (option > 3));

    return option;

} // end of show_menu_and_get_user_option

static void do_manual_testing(void)
{

    char text[ARRAY_SIZE] = {0};
    char pattern[ARRAY_SIZE] = {0};
    long index = -1;

    while (1) {

        system("clear");

        printf("\n\n");

        printf("Please input a text string in which to search the
pattern string"
               " (max %d characters) (To go back to main menu, enter 0
and hit ENTER): ",
               ARRAY_SIZE - 1);
        get_input_from_stdin_and_discard_extra_characters(text, ARRAY_SIZE);
        if(strcmp(text, "0") == 0)
            return;
        if(!text[0]) {
            printf("\n\n");
            printf("Error: Text string is empty. This is invalid.
Please try again..\n");
            printf("\n\n");
            printf("Hit enter to continue...");
            get_input_from_stdin_and_discard_extra_characters(NULL, 0);
            continue;
        }

        printf("\n");

        printf("Please input a pattern string to search in the text string"
               " (max %d characters) (To go back to main menu, enter 0
and hit ENTER): ",
               ARRAY_SIZE - 1);
        get_input_from_stdin_and_discard_extra_characters(pattern, ARRAY_SIZE);
        if(strcmp(pattern, "0") == 0)
            return;
        if(!pattern[0]) {
            printf("\n\n");
            printf("Error: Pattern string is empty. This is invalid.
Please try again..\n");
            printf("\n\n");
            printf("Hit enter to continue...");
            get_input_from_stdin_and_discard_extra_characters(NULL, 0);
            continue;
        }

        index = new_string_search_algorithm(text, pattern);

        printf("\n\n");

        if (index == -1) {
            printf("Output: Pattern not found in the text string.\n");
            printf("\n\n");
            printf("Hit enter to continue...");
            get_input_from_stdin_and_discard_extra_characters(NULL, 0);
            continue;
        }

        printf("Output: Pattern found in text string at index %ld of
text string. ", index);

        if (memcmp(text + index, pattern, strlen(pattern)) == 0) {
            printf("memcmp() also passed.\n");
        } else {
            printf("\n\n");
            printf("Bug: memcmp() didn't pass.\n\n");
            printf("Some bug in program. Crashing the program. File name: %s,"
                   " Line number: %d", __FILE__, __LINE__);
            printf("\n\n");
            *((int *)(-1)) = 123;
        }

        printf("\n\n");
        printf("Please press ENTER to continue..");
        get_input_from_stdin_and_discard_extra_characters(NULL, 0);

    } // end of while (1) loop

} // end of do_manual_testing

static void run_automated_tests(void)
{

    char *text = "The byte is a unit of digital information that most
commonly consists of eight bits. Historically, the byte was the number
of bits used to encode a single character of text in a computer[1][2]
and for this reason it is the smallest addressable unit of memory in
many computer architectures. To disambiguate arbitrarily sized bytes
from the common 8-bit definition, network protocol documents such as
The Internet Protocol (RFC 791) refer to an 8-bit byte as an octet.[3]
Those bits in an octet are usually counted with numbering from 0 to 7
or 7 to 0 depending on the bit endianness. The first bit is number 0,
making the eighth bit number 7. The size of the byte has historically
been hardware-dependent and no definitive standards existed that
mandated the size. Sizes from 1 to 48 bits have been used.[4][5][6][7]
The six-bit character code was an often-used implementation in early
encoding systems, and computers using six-bit and nine-bit bytes were
common in the 1960s. These systems often had memory words of 12, 18,
24, 30, 36, 48, or 60 bits, corresponding to 2, 3, 4, 5, 6, 8, or 10
six-bit bytes. In this era, bit groupings in the instruction stream
were often referred to as syllables[a] or slab, before the term byte
became common. The modern de facto standard of eight bits, as
documented in ISO/IEC 2382-1:1993, is a convenient power of two
permitting the binary-encoded values 0 through 255 for one byte - 2 to
the power of 8 is 256.[8] The international standard IEC 80000-13
codified this common meaning. Many types of applications use
information representable in eight or fewer bits and processor
designers commonly optimize for this usage. The popularity of major
commercial computing architectures has aided in the ubiquitous
acceptance of the 8-bit byte.[9] Modern architectures typically use
32- or 64-bit words, built of four or eight bytes, respectively. The
unit symbol for the byte was designated as the upper-case letter B by
the International Electrotechnical Commission (IEC) and Institute of
Electrical and Electronics Engineers (IEEE).[10] Internationally, the
unit octet, symbol o, explicitly defines a sequence of eight bits,
eliminating the potential ambiguity of the term byte.[11][12]";

    long text_len = (long)(strlen(text));
    char *pattern = NULL;
    long pattern_len = -1;
    long index_to_copy_pattern_from = -1;
    long index = -1;
    long test_num = 0;
    long total_num_tests = 1000000;

    pattern_len = get_random_number(1, text_len);

    index_to_copy_pattern_from = get_random_number(0, text_len - pattern_len);

    pattern = malloc((size_t)(text_len + 1)); // 1 extra for null byte
    if (!pattern) {
        printf("\n\n");
        printf("No memory. Could not allocate memory for pattern.\n");
        printf("\n\n");
        printf("Please press ENTER to continue..");
        get_input_from_stdin_and_discard_extra_characters(NULL, 0);
        return;
    }

    memmove(pattern, text + index_to_copy_pattern_from, (size_t)(pattern_len));
    pattern[pattern_len] = 0;

    system("clear");

    printf("\n\n");

    printf("Running automated tests..\n\n\n");

    while (test_num != total_num_tests) {

        printf("\r");
        printf("Running test %ld/%ld: ", test_num + 1, total_num_tests);

        index = new_string_search_algorithm(text, pattern);

        if (index == -1) {
            printf("FAILED.%*s\n", 120, "");
            printf("\n\n");
            printf("Test should not fail. Crashing the program. File name: %s,"
                   " Line number: %d", __FILE__, __LINE__);
            printf("\n\n");
            *((int *)(-1)) = 123;
        }

        printf("PASSED. ");

        if (memcmp(text + index_to_copy_pattern_from, pattern,
(size_t)(pattern_len)) != 0) {
            printf("memcmp() FAILED.%*s\n", 120, "");
            printf("\n\n");
            printf("memcmp() should not fail. Crashing the program.
File name: %s,"
                   " Line number: %d", __FILE__, __LINE__);
            printf("\n\n");
            *((int *)(-1)) = 123;
        }

        printf("memcmp() also PASSED.");

        test_num = test_num + 1;

    } // end of while

    printf("\n\n");
    printf("All tests passed.\n");
    printf("\n\n");
    printf("Please press ENTER to continue..");
    get_input_from_stdin_and_discard_extra_characters(NULL, 0);

    return;

} // end of run_automated_tests

static long get_random_number(long lower, long upper)
{

    srandom((unsigned int)(time(NULL)));

    return ((random() % (upper - lower + 1)) + lower);

} // end of get_random_number

static char *get_input_from_stdin_and_discard_extra_characters(char
*str, long size)
{

    int c = 0;
    long i = 0;

    // If 'size' is 0 then this function will discard all input and return NULL.
    // No need to check 'str' if 'size' is 0.
    if (size == 0) {
        // discard all input
        while ((c = getchar()) && (c != '\n') && (c != EOF));
        return NULL;
    }

    if (!str)
        return str;

    if (size < 0)
        return NULL;

    for (i = 0; i < (size - 1); i = i + 1) {

        c = getchar();

        if ((c == '\n') || (c == EOF)) {
            str[i] = 0;
            return str;
        }

        str[i] = (char)(c);

    } // end of for loop

    str[i] = 0;

    // discard rest of input
    while ((c = getchar()) && (c != '\n') && (c != EOF));

    return str;

} // end of get_input_from_stdin_and_discard_extra_characters
